class Solution:
    def repairCars(self, cars: List[int], n: int) -> int:
        left, right = 1, max(cars) * n
        while left < right:
            mid = (left + right) // 2
            if sum((mid // car) for car in cars) >= n:
                right = mid
            else:
                left = mid + 1
        return left