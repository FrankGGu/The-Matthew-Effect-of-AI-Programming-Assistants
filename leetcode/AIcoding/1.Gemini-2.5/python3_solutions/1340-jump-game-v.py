class Solution:
    def maxJumps(self, arr: list[int], d: int) -> int:
        n = len(arr)
        dp = [-1] * n

        def dfs(i: int) -> int:
            if dp[i] != -1:
                return dp[i]

            max_jumps_from_i = 1

            # Jump to the right
            for j in range(i + 1, min(n, i + d + 1)):
                if arr[j] >= arr[i]:
                    break
                max_jumps_from_i = max(max_jumps_from_i, 1 + dfs(j))

            # Jump to the left
            for j in range(i - 1, max(-1, i - d - 1), -1):
                if arr[j] >= arr[i]:
                    break
                max_jumps_from_i = max(max_jumps_from_i, 1 + dfs(j))

            dp[i] = max_jumps_from_i
            return max_jumps_from_i

        overall_max_jumps = 0
        for i in range(n):
            overall_max_jumps = max(overall_max_jumps, dfs(i))

        return overall_max_jumps