import collections

class Solution:
    def minimumCost(self, nums: list[int], k: int) -> int:
        n = len(nums)

        # Step 1: Precompute valid starting indices
        # An index `i` (for i > 0) is valid if nums[i] is the smallest element
        # in nums[i-1], nums[i-2], ..., nums[max(0, i-k)] (inclusive).
        # We interpret "is the smallest element in" as `nums[i] <= min(window_elements)`.

        valid_indices = [False] * n
        valid_indices[0] = True # Index 0 is always a valid starting point

        # Deque for sliding window minimum to find min(nums[max(0, i-k) ... i-1])
        # Stores (value, index) pairs in increasing order of value.
        dq_window_min = collections.deque()

        for i in range(1, n):
            # Add nums[i-1] to the deque for the window that ends at i-1.
            # Remove elements from the back that are greater than or equal to nums[i-1].
            while dq_window_min and dq_window_min[-1][0] >= nums[i-1]:
                dq_window_min.pop()
            dq_window_min.append((nums[i-1], i-1))

            # Remove elements from the front that are outside the current window [max(0, i-k), i-1].
            # Elements with index less than i-k should be removed.
            if dq_window_min[0][1] < i - k:
                dq_window_min.popleft()

            # Check if nums[i] satisfies the condition
            # If the window is empty (e.g., k=0 or i=0), this logic needs care.
            # For i > 0, the window [max(0, i-k), i-1] is well-defined.
            # If dq_window_min is empty, it means the window itself is empty or contains only elements
            # that were removed because they were too old. This should not happen if k >= 1.
            # For k=1, window is [i-1, i-1]. dq_window_min will contain (nums[i-1], i-1).
            # The minimum in the window is dq_window_min[0][0].
            min_in_window = dq_window_min[0][0]
            if nums[i] <= min_in_window:
                valid_indices[i] = True

        # Step 2: Dynamic Programming with sliding window minimum on DP values
        # dp[i] will store the minimum cost to form `j` subarrays, where the `j`-th subarray starts at `i`.
        # We iterate `k-1` times to find the minimum cost for 2, 3, ..., k subarrays.

        dp = [float('inf')] * n
        dp[0] = nums[0] # Base case: 1 subarray, starts at index 0, cost is nums[0]

        # Loop for `k-1` additional subarrays (from 2nd to k-th subarray)
        for _ in range(k - 1):
            next_dp = [float('inf')] * n

            # Deque for sliding window minimum on `dp` values
            # Stores (dp_value, index) pairs in increasing order of dp_value.
            dq_dp_min = collections.deque()

            # Initialize deque with dp[0] if it's a valid starting point for the previous step.
            # Since dp[0] is always valid (cost for 1 subarray), add it.
            if dp[0] != float('inf'):
                dq_dp_min.append((dp[0], 0))

            # Iterate through possible starting points `i` for the current subarray
            for i in range(1, n):
                # Remove elements from the front of dq_dp_min that are too far.
                # A previous starting point `p` must be in the window `[i-k, i-1]`.
                while dq_dp_min and dq_dp_min[0][1] < i - k:
                    dq_dp_min.popleft()

                # If `i` is a valid starting point (from precomputation) and there are valid previous states in dq_dp_min
                if valid_indices[i] and dq_dp_min:
                    # The cost is nums[i] plus the minimum cost to reach a previous valid starting point `p`.
                    next_dp[i] = nums[i] + dq_dp_min[0][0]

                # Add current `dp[i]` to dq_dp_min for future calculations (when `i` becomes `p`).
                # Only add if `dp[i]` is a reachable state (not infinity).
                if dp[i] != float('inf'):
                    while dq_dp_min and dq_dp_min[-1][0] >= dp[i]:
                        dq_dp_min.pop()
                    dq_dp_min.append((dp[i], i))

            dp = next_dp

        # The minimum cost is the minimum value in the final `dp` array.
        # This will be `float('inf')` if no valid division into `k` subarrays is found.
        min_final_cost = float('inf')
        for cost in dp:
            min_final_cost = min(min_final_cost, cost)

        return min_final_cost