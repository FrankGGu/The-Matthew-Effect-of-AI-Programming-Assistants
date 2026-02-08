class Solution:
    def countSpecialIntegers(self, n: int) -> int:
        s = str(n)
        m = len(s)
        dp = {}

        def solve(idx, mask, is_limit, is_num):
            if idx == m:
                return 1 if is_num else 0

            if (idx, mask, is_limit, is_num) in dp:
                return dp[(idx, mask, is_limit, is_num)]

            ans = 0
            if not is_num:
                ans += solve(idx + 1, mask, False, False)

            up = int(s[idx]) if is_limit else 9

            for i in range(0 if is_num else 1, up + 1):
                if (mask & (1 << i)) == 0:
                    ans += solve(idx + 1, mask | (1 << i), is_limit and i == up, True)

            dp[(idx, mask, is_limit, is_num)] = ans
            return ans

        return solve(0, 0, True, False)