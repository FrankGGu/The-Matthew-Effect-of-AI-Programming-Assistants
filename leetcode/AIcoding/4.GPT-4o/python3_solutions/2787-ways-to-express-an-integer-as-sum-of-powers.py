class Solution:
    def powerfulIntegers(self, x: int, y: int, bound: int) -> List[int]:
        result = set()
        for i in range(0, 23):  # 2^20 > 10^6
            for j in range(0, 23):  # 2^20 > 10^6
                power_x = x ** i if x > 1 else 1
                power_y = y ** j if y > 1 else 1
                sum_power = power_x + power_y
                if sum_power > bound:
                    break
                result.add(sum_power)
        return list(result)