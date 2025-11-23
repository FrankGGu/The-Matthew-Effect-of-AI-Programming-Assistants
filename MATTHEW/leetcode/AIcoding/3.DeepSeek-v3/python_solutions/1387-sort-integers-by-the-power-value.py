class Solution:
    def getKth(self, lo: int, hi: int, k: int) -> int:
        power_cache = {1: 0}

        def get_power(x):
            if x in power_cache:
                return power_cache[x]
            if x % 2 == 0:
                power = 1 + get_power(x // 2)
            else:
                power = 1 + get_power(3 * x + 1)
            power_cache[x] = power
            return power

        numbers = []
        for num in range(lo, hi + 1):
            power = get_power(num)
            numbers.append((power, num))

        numbers.sort()
        return numbers[k - 1][1]