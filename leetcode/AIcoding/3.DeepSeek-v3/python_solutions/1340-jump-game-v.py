class Solution:
    def maxJumps(self, arr: List[int], d: int) -> int:
        n = len(arr)
        dp = [1] * n
        indices = sorted(range(n), key=lambda x: arr[x])

        for i in indices:
            for di in [-1, 1]:
                for j in range(i + di, i + di + d * di, di):
                    if 0 <= j < n and arr[j] < arr[i]:
                        dp[i] = max(dp[i], dp[j] + 1)
                    else:
                        break
        return max(dp)