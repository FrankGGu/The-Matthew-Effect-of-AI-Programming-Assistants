class Solution:
    def getKth(self, lo: int, hi: int, k: int) -> int:
        def power_value(n):
            steps = 0
            while n != 1:
                if n % 2 == 0:
                    n //= 2
                else:
                    n = 3 * n + 1
                steps += 1
            return steps

        power_values = [(power_value(i), i) for i in range(lo, hi + 1)]
        power_values.sort()
        return power_values[k - 1][1]