class SegmentTree:
    def __init__(self, n):
        self.n = n
        # Each node stores [sum_C, sum_C_sq, lazy_add]
        # sum_C: sum of distinct counts in the segment
        # sum_C_sq: sum of squares of distinct counts in the segment
        # lazy_add: value to be added to all distinct counts in the segment
        self.tree = [[0, 0, 0] for _ in range(4 * n)]
        self.MOD = 10**9 + 7

    def _apply_lazy(self, idx, start, end, val_to_add):
        length = (end - start + 1)

        current_sum_C = self.tree[idx][0]
        current_sum_C_sq = self.tree[idx][1]
        current_lazy_add = self.tree[idx][2]

        val_mod = val_to_add % self.MOD

        # New sum_C_sq = sum( (C_i + V)^2 ) = sum( C_i^2 + 2*V*C_i + V^2 )
        # = sum(C_i^2) + 2*V*sum(C_i) + V^2 * length
        term1 = current_sum_C_sq
        term2 = (2 * val_mod * current_sum_C) % self.MOD
        term3 = (val_mod * val_mod * length) % self.MOD

        new_sum_C_sq = (term1 + term2 + term3) % self.MOD

        # New sum_C = sum( C_i + V ) = sum(C_i) + V * length
        new_sum_C = (current_sum_C + val_mod * length) % self.MOD

        # New lazy_add = current_lazy_add + V
        new_lazy_add = (current_lazy_add + val_mod) % self.MOD

        self.tree[idx][0] = new_sum_C
        self.tree[idx][1] = new_sum_C_sq
        self.tree[idx][2] = new_lazy_add

    def _push_down(self, idx, start, end):
        # Only push down if there's a lazy tag and it's not a leaf node
        if self.tree[idx][2] != 0 and start != end:
            mid = (start + end) // 2
            # Apply lazy tag to left child
            self._apply_lazy(2 * idx, start, mid, self.tree[idx][2])
            # Apply lazy tag to right child
            self._apply_lazy(2 * idx + 1, mid + 1, end, self.tree[idx][2])
            # Clear lazy tag of current node
            self.tree[idx][2] = 0

    def _merge(self, idx):
        # Merge results from children to parent
        left_child = self.tree[2 * idx]
        right_child = self.tree[2 * idx + 1]
        self.tree[idx][0] = (left_child[0] + right_child[0]) % self.MOD
        self.tree[idx][1] = (left_child[1] + right_child[1]) % self.MOD

    def update_range(self, idx, start, end, query_L, query_R, val):
        # If query range is invalid or outside current segment
        if query_L > query_R or start > query_R or end < query_L:
            return

        # If current segment is fully contained within query range
        if query_L <= start and end <= query_R:
            self._apply_lazy(idx, start, end, val)
            return

        # Push down lazy tag before recursing
        self._push_down(idx, start, end)
        mid = (start + end) // 2

        # Recurse on children
        self.update_range(2 * idx, start, mid, query_L, query_R, val)
        self.update_range(2 * idx + 1, mid + 1, end, query_L, query_R, val)

        # Merge results from children
        self._merge(idx)

    def query_sum_sq(self, idx, start, end, query_L, query_R):
        # If query range is invalid or outside current segment
        if query_L > query_R or start > query_R or end < query_L:
            return 0

        # If current segment is fully contained within query range
        if query_L <= start and end <= query_R:
            return self.tree[idx][1]

        # Push down lazy tag before recursing
        self._push_down(idx, start, end)
        mid = (start + end) // 2

        # Recurse and sum results from children
        left_sq = self.query_sum_sq(2 * idx, start, mid, query_L, query_R)
        right_sq = self.query_sum_sq(2 * idx + 1, mid + 1, end, query_L, query_R)

        return (left_sq + right_sq) % self.MOD

class Solution:
    def sumCounts(self, nums: list[int]) -> int:
        n = len(nums)
        MOD = 10**9 + 7

        # prev_idx[i] stores the index of the previous occurrence of nums[i]
        # or -1 if it's the first occurrence.
        prev_idx = [-1] * n
        last_seen = {} # Maps value to its last seen index
        for i in range(n):
            if nums[i] in last_seen:
                prev_idx[i] = last_seen[nums[i]]
            last_seen[nums[i]] = i

        seg_tree = SegmentTree(n)
        total_ans = 0

        # Iterate through each possible right endpoint `j` of subarrays
        for j in range(n):
            p = prev_idx[j]

            # Update step:
            # For any subarray nums[k...j], nums[j] is a distinct element if its previous
            # occurrence `p` is less than `k`.
            # This means for k in [p+1, j], the distinct count increases by 1.
            # (distinct_count(k, j) = distinct_count(k, j-1) + 1)
            # For k in [0, p], distinct_count(k, j) = distinct_count(k, j-1)
            # The segment tree stores distinct_count(k, current_j) for k in [0, current_j].
            # So, we add 1 to the range [p+1, j].
            # This covers:
            # - For k in [p+1, j-1], distinct_count(k, j) becomes distinct_count(k, j-1) + 1
            # - For k = j, distinct_count(j, j) is 1. Since distinct_count(j, j-1) was 0, adding 1 is correct.
            seg_tree.update_range(1, 0, n - 1, p + 1, j, 1)

            # Query sum of squares for all subarrays ending at `j`.
            # These are subarrays nums[k...j] for k in [0, j].
            # The segment tree currently holds distinct_count(k, j) for k in [0, j].
            current_sum_sq = seg_tree.query_sum_sq(1, 0, n - 1, 0, j)
            total_ans = (total_ans + current_sum_sq) % MOD

        return total_ans