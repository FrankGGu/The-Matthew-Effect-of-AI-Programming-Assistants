class Solution:
    def longestBalancedString(self, a: int, b: int, c: int) -> int:
        ans = 0
        ans += min(a, b) * 2
        a -= min(a, b)
        b -= min(a, b)

        ans += min(b, c) * 2
        b -= min(b, c)
        c -= min(b, c)

        ans += min(a, c) * 2
        a -= min(a, c)
        c -= min(a, c)

        if a > 0:
            ans += min(a, b + c + 1) * 2
        elif b > 0:
            ans += min(b, a + c + 1) * 2
        elif c > 0:
            ans += min(c, a + b + 1) * 2

        return ans