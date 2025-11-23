class Solution:
    def shortestToChar(self, s: str, c: str) -> list[int]:
        n = len(s)
        ans = [float('inf')] * n

        for i in range(n):
            if s[i] == c:
                ans[i] = 0

        for i in range(1, n):
            ans[i] = min(ans[i], ans[i-1] + 1)

        for i in range(n-2, -1, -1):
            ans[i] = min(ans[i], ans[i+1] + 1)

        return ans