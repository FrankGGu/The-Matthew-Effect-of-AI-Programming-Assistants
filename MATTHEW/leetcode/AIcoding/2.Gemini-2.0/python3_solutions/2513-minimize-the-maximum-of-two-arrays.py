import math

class Solution:
    def minimizeSet(self, divisor1: int, divisor2: int, uniqueCnt1: int, uniqueCnt2: int) -> int:
        def check(mid):
            cnt1 = mid - mid // divisor1
            cnt2 = mid - mid // divisor2
            cnt12 = mid - mid // divisor1 - mid // divisor2 + mid // (divisor1 * divisor2 // math.gcd(divisor1, divisor2))
            return cnt1 >= uniqueCnt1 and cnt2 >= uniqueCnt2 and cnt12 >= uniqueCnt1 + uniqueCnt2

        left, right = 1, 10**10
        while left < right:
            mid = (left + right) // 2
            if check(mid):
                right = mid
            else:
                left = mid + 1
        return left