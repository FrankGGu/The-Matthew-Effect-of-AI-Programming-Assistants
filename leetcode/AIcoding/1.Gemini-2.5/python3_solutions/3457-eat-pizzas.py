class Solution:
    def maxSizeSlices(self, slices: list[int]) -> int:
        def solve_linear(arr: list[int], k: int) -> int:
            m = len(arr)
            # dp[i][j] = maximum sum picking j slices from arr[0...i-1]
            # i goes from 0 to m (representing prefix length)
            # j goes from 0 to k (number of slices to pick)
            dp = [[float('-inf')] * (k + 1) for _ in range(m + 1)]

            # Base case: 0 slices picked always yields 0 sum
            for i in range(m + 1):
                dp[i][0] = 0

            # Helper to safely get DP values, handling out-of-bounds and 0-slice cases
            def get_dp_value(idx: int, count: int) -> int:
                if count == 0:
                    return 0
                if idx < 0:
                    return float('-inf')
                return dp[idx][count]

            for i in range(1, m + 1):  # Current element being considered is arr[i-1]
                for j in range(1, k + 1):  # Number of slices to pick
                    # Option 1: Don't pick arr[i-1]
                    # The max sum is the same as picking j slices from arr[0...i-2]
                    dp[i][j] = get_dp_value(i - 1, j)

                    # Option 2: Pick arr[i-1]
                    # If we pick arr[i-1], we cannot pick arr[i-2].
                    # So, we need to pick j-1 slices from arr[0...i-3] (prefix of length i-2)
                    val_if_pick = arr[i - 1] + get_dp_value(i - 2, j - 1)

                    dp[i][j] = max(dp[i][j], val_if_pick)

            return dp[m][k]

        n_total = len(slices)
        k = n_total // 3

        # Case 1: Exclude the last slice (slices[n_total-1])
        # This means we consider slices from index 0 to n_total-2
        res1 = solve_linear(slices[:-1], k)

        # Case 2: Exclude the first slice (slices[0])
        # This means we consider slices from index 1 to n_total-1
        res2 = solve_linear(slices[1:], k)

        # The maximum of these two cases is the answer for the circular arrangement
        return max(res1, res2)