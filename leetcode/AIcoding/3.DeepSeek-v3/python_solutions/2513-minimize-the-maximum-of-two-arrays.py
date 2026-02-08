import math

class Solution:
    def minimizeSet(self, d1: int, d2: int, uniqueCnt1: int, uniqueCnt2: int) -> int:
        def is_possible(m):
            not_div_by_d1 = m - m // d1
            not_div_by_d2 = m - m // d2
            not_div_by_both = m - m // d1 - m // d2 + m // (d1 * d2 // math.gcd(d1, d2))

            a = max(uniqueCnt1 - (m // d2 - m // (d1 * d2 // math.gcd(d1, d2))), 0)
            b = max(uniqueCnt2 - (m // d1 - m // (d1 * d2 // math.gcd(d1, d2))), 0)

            total = a + b
            return not_div_by_both >= total and not_div_by_d1 >= uniqueCnt1 and not_div_by_d2 >= uniqueCnt2

        left, right = 1, 2 * 10**9
        answer = right

        while left <= right:
            mid = (left + right) // 2
            if is_possible(mid):
                answer = mid
                right = mid - 1
            else:
                left = mid + 1

        return answer