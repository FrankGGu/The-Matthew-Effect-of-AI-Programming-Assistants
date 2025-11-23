class Solution:
    def maxJumps(self, arr: List[int], d: int) -> int:
        n = len(arr)
        dp = [1] * n
        indices = sorted(range(n), key=lambda i: arr[i])

        for i in indices:
            for j in range(i + 1, min(i + d + 1, n)):
                if arr[j] < arr[i]:
                    dp[j] = max(dp[j], dp[i] + 1)
                else:
                    break

            for j in range(i - 1, max(i - d - 1, -1), -1):
                if arr[j] < arr[i]:
                    dp[j] = max(dp[j], dp[i] + 1)
                else:
                    break

        return max(dp)