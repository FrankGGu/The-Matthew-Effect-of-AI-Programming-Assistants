import math

class Solution:
    def repairCars(self, ranks: list[int], cars: int) -> int:

        def check(time_limit: int) -> bool:
            total_cars_repaired = 0
            for r in ranks:
                cars_by_this_mechanic = math.isqrt(time_limit // r)
                total_cars_repaired += cars_by_this_mechanic
            return total_cars_repaired >= cars

        low = 1
        high = max(ranks) * cars * cars
        ans = high

        while low <= high:
            mid = low + (high - low) // 2
            if check(mid):
                ans = mid
                high = mid - 1
            else:
                low = mid + 1

        return ans