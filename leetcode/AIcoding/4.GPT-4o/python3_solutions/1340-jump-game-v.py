class Solution:
    def maxJumps(self, arr: List[int], d: int) -> int:
        n = len(arr)
        dp = [1] * n
        indices = sorted(range(n), key=lambda i: arr[i])

        for i in indices:
            for j in range(1, d + 1):
                if i + j < n and arr[i + j] < arr[i]:
                    dp[i + j] = max(dp[i + j], dp[i] + 1)
                else:
                    break
                if i - j >= 0 and arr[i - j] < arr[i]:
                    dp[i - j] = max(dp[i - j], dp[i] + 1)
                else:
                    break

        return max(dp)