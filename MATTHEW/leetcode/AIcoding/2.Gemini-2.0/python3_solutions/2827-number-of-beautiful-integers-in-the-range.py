class Solution:
    def numberOfBeautifulIntegers(self, low: int, high: int, k: int) -> int:
        def count_beautiful(n):
            s = str(n)
            l = len(s)
            memo = {}

            def dp(idx, rem, tight):
                if idx == l:
                    return rem == 0

                if (idx, rem, tight) in memo:
                    return memo[(idx, rem, tight)]

                ub = int(s[idx]) if tight else 9
                ans = 0
                for d in range(ub + 1):
                    new_rem = (rem * 10 + d) % k
                    new_tight = tight and (d == ub)
                    ans += dp(idx + 1, new_rem, new_tight)

                memo[(idx, rem, tight)] = ans
                return ans

            return dp(0, 0, True)

        return count_beautiful(high) - count_beautiful(low - 1)