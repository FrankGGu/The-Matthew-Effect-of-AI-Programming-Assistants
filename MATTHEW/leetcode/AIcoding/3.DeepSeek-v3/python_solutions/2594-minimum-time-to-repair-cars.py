import math

class Solution:
    def repairCars(self, ranks: List[int], cars: int) -> int:
        left = 1
        right = min(ranks) * cars * cars

        def can_repair_all(time):
            total = 0
            for r in ranks:
                total += int(math.sqrt(time // r))
                if total >= cars:
                    return True
            return total >= cars

        while left < right:
            mid = (left + right) // 2
            if can_repair_all(mid):
                right = mid
            else:
                left = mid + 1
        return left