class Solution:
    def repairCars(self, ranks: List[int], cars: int) -> int:
        def check(time):
            repaired_cars = 0
            for rank in ranks:
                repaired_cars += int((time / rank)**0.5)
            return repaired_cars >= cars

        left, right = 0, max(ranks) * cars * cars
        ans = right
        while left <= right:
            mid = (left + right) // 2
            if check(mid):
                ans = mid
                right = mid - 1
            else:
                left = mid + 1

        return ans