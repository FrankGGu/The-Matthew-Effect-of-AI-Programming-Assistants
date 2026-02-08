class Solution:
    def findPossibleStableArrays(self, n: int, zeroes: int) -> int:
        if zeroes == 0 or zeroes == n:
            return 1

        ones = n - zeroes

        if ones == 0:
            return 1

        dp = {}

        def solve(idx, last):
            if idx == n:
                return 1

            if (idx, last) in dp:
                return dp[(idx, last)]

            res = 0

            if zeroes > 0:
                zeroes_temp = zeroes - 1
                if last != 0:
                    zeroes_temp +=1
                if zeroes_temp >= 0:
                    zeroes_temp = zeroes - 1
                    zeroes -=1
                    res += solve(idx + 1, 0)
                    zeroes +=1

            if ones > 0:
                ones -=1
                res += solve(idx+1, 1)
                ones +=1

            dp[(idx, last)] = res
            return res

        return solve(0, -1)