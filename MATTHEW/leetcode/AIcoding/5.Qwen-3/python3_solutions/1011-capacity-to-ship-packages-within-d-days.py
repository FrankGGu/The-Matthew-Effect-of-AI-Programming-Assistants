class Solution:
    def shipWithinDays(self, weights: List[int], D: int) -> int:
        left = max(weights)
        right = sum(weights)

        def canShip(capacity):
            days = 1
            current = 0
            for weight in weights:
                if current + weight > capacity:
                    days += 1
                    current = weight
                else:
                    current += weight
            return days <= D

        while left < right:
            mid = (left + right) // 2
            if canShip(mid):
                right = mid
            else:
                left = mid + 1
        return left