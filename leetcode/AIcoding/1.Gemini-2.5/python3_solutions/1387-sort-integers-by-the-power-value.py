class Solution:
    _memo = {1: 0}

    def getKth(self, lo: int, hi: int, k: int) -> int:

        def _get_power_value(n: int) -> int:
            if n == 1:
                return 0
            if n in Solution._memo:
                return Solution._memo[n]

            if n % 2 == 0:
                Solution._memo[n] = 1 + _get_power_value(n // 2)
            else:
                Solution._memo[n] = 1 + _get_power_value(3 * n + 1)
            return Solution._memo[n]

        power_values = []
        for i in range(lo, hi + 1):
            power_values.append((_get_power_value(i), i))

        power_values.sort()

        return power_values[k - 1][1]