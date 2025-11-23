class Solution:
    def tilingRectangle(self, n: int, m: int) -> int:
        dp = {}

        def solve(h, w):
            if (h, w) in dp:
                return dp[(h, w)]
            if h == w:
                return 1
            if h > w:
                h, w = w, h
            if h == 1:
                return w
            ans = float('inf')
            for i in range(1, h + 1):
                ans = min(ans, 1 + solve(h - i, w) + solve(i, w - i))
                ans = min(ans, 1 + solve(h, w - i) + solve(h - i, i))
            dp[(h, w)] = ans
            return ans

        return solve(n, m)