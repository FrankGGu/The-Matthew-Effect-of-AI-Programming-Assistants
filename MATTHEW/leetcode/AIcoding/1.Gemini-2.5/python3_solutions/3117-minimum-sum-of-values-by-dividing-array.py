import collections

class SegmentTree:
    def __init__(self, n):
        self.n = n
        # Each node stores (min_cost, min_count)
        self.tree = [(float('inf'), 0)] * (4 * n)
        # Lazy tag for range_add operations (only affects cost, not count)
        self.lazy = [0] * (4 * n)

    def _push(self, idx):
        if self.lazy[idx] != 0:
            # Apply lazy tag to left child
            self.tree[2 * idx + 1] = (self.tree[2 * idx + 1][0] + self.lazy[idx], self.tree[2 * idx + 1][1])
            self.lazy[2 * idx + 1] += self.lazy[idx]
            # Apply lazy tag to right child
            self.tree[2 * idx + 2] = (self.tree[2 * idx + 2][0] + self.lazy[idx], self.tree[2 * idx + 2][1])
            self.lazy[2 * idx + 2] += self.lazy[idx]
            self.lazy[idx] = 0

    def _merge(self, left_node, right_node):
        # Merge logic for (min_cost, min_count)
        if left_node[0] < right_node[0]:
            return left_node
        elif right_node[0] < left_node[0]:
            return right_node
        else:
            # If costs are equal, choose the one with fewer segments
            return (left_node[0], min(left_node[1], right_node[1]))

    def update(self, idx, L, R, target_idx, val_cost, val_count):
        # Point update operation
        if L == R:
            self.tree[idx] = (val_cost, val_count)
            self.lazy[idx] = 0 # Reset lazy when directly updating a leaf
            return

        self._push(idx) # Push lazy tag down before descending
        mid = (L + R) // 2
        if target_idx <= mid:
            self.update(2 * idx + 1, L, mid, target_idx, val_cost, val_count)
        else:
            self.update(2 * idx + 2, mid + 1, R, target_idx, val_cost, val_count)
        self.tree[idx] = self._merge(self.tree[2 * idx + 1], self.tree[2 * idx + 2])

    def range_add(self, idx, L, R, query_L, query_R, add_val):
        # Range add operation
        if query_L > R or query_R < L: # No overlap
            return

        if query_L <= L and R <= query_R: # Full overlap
            self.tree[idx] = (self.tree[idx][0] + add_val, self.tree[idx][1])
            self.lazy[idx] += add_val
            return

        self._push(idx) # Push lazy tag down before descending
        mid = (L + R) // 2
        self.range_add(2 * idx + 1, L, mid, query_L, query_R, add_val)
        self.range_add(2 * idx + 2, mid + 1, R, query_L, query_R, add_val)
        self.tree[idx] = self._merge(self.tree[2 * idx + 1], self.tree[2 * idx + 2])

    def query(self, idx, L, R, query_L, query_R):
        # Range minimum query
        if query_L > R or query_R < L: # No overlap
            return (float('inf'), 0)

        if query_L <= L and R <= query_R: # Full overlap
            return self.tree[idx]

        self._push(idx) # Push lazy tag down before descending
        mid = (L + R) // 2
        left_res = self.query(2 * idx + 1, L, mid, query_L, query_R)
        right_res = self.query(2 * idx + 2, mid + 1, R, query_L, query_R)
        return self._merge(left_res, right_res)

class Solution:
    def minimumSum(self, nums: list[int], k: int) -> int:
        n = len(nums)

        # This function computes the minimum total cost and the number of segments
        # for a given 'lambda_penalty'.
        # The cost for a segment is `nums[L] + min(nums[L...R]) + lambda_penalty`.
        def solve(lambda_penalty):
            # dp[i] = min cost to partition nums[0...i-1]
            # count[i] = number of segments for dp[i]
            dp = [float('inf')] * (n + 1)
            count = [0] * (n + 1)

            # Segment tree operates on indices 0 to n-1 (representing 'p' in DP transition).
            segment_tree = SegmentTree(n)

            # Base case: dp[0] = 0, count[0] = 0 (empty prefix, 0 cost, 0 segments).
            # Initialize segment tree for p=0.
            # The value stored at index `p` in the segment tree is:
            # `dp[p] + nums[p] + min_val_in_segment_ending_at_i + lambda_penalty`.
            # For p=0, `dp[0]=0`, `nums[0]` is the first element of the segment,
            # `min_val_in_segment_ending_at_i` is initially `nums[0]` (for segment `nums[0...0]`).
            # So, `dp[0] + nums[0] + nums[0] + lambda_penalty`.
            # The count is `count[0] + 1 = 1`.
            segment_tree.update(0, 0, n - 1, 0, nums[0] + nums[0] + lambda_penalty, 1)

            # Monotonic stack to efficiently handle `min(nums[p...i])` term.
            # Stores indices `idx` such that `nums[idx]` is decreasing.
            mono_stack = collections.deque()
            mono_stack.append(0) # `nums[0]` is the first element

            # Iterate `i` from 1 to n-1. `i` is the current index of `nums[i]`,
            # which is the rightmost element of the current segment `nums[p...i]`.
            for i in range(1, n):
                val = nums[i]

                # Update segment tree based on `nums[i]`
                # For `p` in `[left_bound, top_idx]`, `nums[top_idx]` was the minimum in `nums[p...i-1]`.
                # Now `val` (`nums[i]`) becomes the minimum in `nums[p...i]`.
                # The `min_term` changes from `nums[top_idx]` to `val`.
                # We add `val - nums[top_idx]` to the segment tree values for `p` in `[left_bound, top_idx]`.
                while mono_stack and nums[mono_stack[-1]] >= val:
                    top_idx = mono_stack.pop()
                    left_bound = mono_stack[-1] + 1 if mono_stack else 0
                    segment_tree.range_add(0, n - 1, left_bound, top_idx, val - nums[top_idx])
                mono_stack.append(i)

                # Query the segment tree to find `dp[i+1]`
                # `dp[i+1]` is the minimum cost to partition `nums[0...i]`.
                # We query for `p` from `0` to `i`.
                # The segment tree stores `dp_prev[p] + nums[p] + min(nums[p...i]) + lambda_penalty`.
                min_cost_val, min_count_val = segment_tree.query(0, n - 1, 0, i)
                dp[i+1] = min_cost_val
                count[i+1] = min_count_val

                # Prepare for the next iteration (`i+1` as the start of a new segment).
                # Update segment tree at index `i+1` with `dp[i+1]` as `dp_prev` for future calculations.
                # `dp[i+1] + nums[i+1] + nums[i+1] + lambda_penalty`
                # The first `nums[i+1]` is the `nums[p]` term (where `p=i+1`).
                # The second `nums[i+1]` is `min(nums[p...p])` (for `p=i+1`).
                # `count[i+1] + 1` for the new segment.
                if i + 1 < n:
                    if dp[i+1] != float('inf'):
                        segment_tree.update(0, n - 1, i + 1, dp[i+1] + nums[i+1] + nums[i+1] + lambda_penalty, count[i+1] + 1)
                    else:
                        segment_tree.update(0, n - 1, i + 1, float('inf'), 0) # If dp[i+1] is inf, so is this path

            # dp[n] contains the total cost including `lambda_penalty * count[n]`.
            # We return the actual sum of values by subtracting `lambda_penalty * k`.
            return dp[n] - lambda_penalty * k, count[n]

        # Binary search for `lambda_penalty`.
        # `lambda_penalty` can range from 0 (no penalty) to 2 * 10^9 + 7 (a value larger than any possible segment cost).
        low = 0
        high = 2 * 10**9 + 7

        ans_cost = float('inf')
        ans_count = 0

        while low <= high:
            mid = low + (high - low) // 2
            current_cost, current_count = solve(mid)

            # If `current_count` is >= `k`, it means `mid` is too small or just right.
            # We try a larger `lambda` to reduce the segment count, or keep `mid` if it's optimal.
            # We want to find the largest `lambda` that still gives at least `k` segments.
            # This corresponds to the minimal actual cost.
            if current_count >= k:
                ans_cost = current_cost
                ans_count = current_count
                low = mid + 1
            else: # current_count < k, `mid` is too large
                high = mid - 1

        return ans_cost