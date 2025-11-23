import math

class Solution:
    def closestDivisors(self, num: int) -> list[int]:
        def find_closest_pair(n: int) -> list[int]:
            sqrt_n = int(math.sqrt(n))
            for i in range(sqrt_n, 0, -1):
                if n % i == 0:
                    return [i, n // i]
            return [] # Should not happen for n >= 1

        pair1 = find_closest_pair(num + 1)
        pair2 = find_closest_pair(num + 2)

        diff1 = abs(pair1[0] - pair1[1])
        diff2 = abs(pair2[0] - pair2[1])

        if diff1 <= diff2:
            return pair1
        else:
            return pair2