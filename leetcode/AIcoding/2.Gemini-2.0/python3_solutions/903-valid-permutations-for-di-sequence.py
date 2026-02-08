class Solution:
    def validPermutations(self, s: str) -> int:
        n = len(s)
        dp = {}
        MOD = 10**9 + 7

        def solve(idx, last, mask):
            if idx == n + 1:
                return 1

            if (idx, last, mask) in dp:
                return dp[(idx, last, mask)]

            ans = 0
            if s[idx-1] == 'I':
                for i in range(last + 1, n + 1):
                    if (mask & (1 << i)) == 0:
                        ans = (ans + solve(idx + 1, i, mask | (1 << i))) % MOD
            else:
                for i in range(last - 1, -1, -1):
                    if (mask & (1 << i)) == 0:
                        ans = (ans + solve(idx + 1, i, mask | (1 << i))) % MOD

            dp[(idx, last, mask)] = ans
            return ans

        res = 0
        for i in range(n + 1):
            res = (res + solve(1, i, 1 << i)) % MOD

        return res