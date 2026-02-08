class Solution:
    def shipWithinDays(self, weights: List[int], D: int) -> int:
        def canShip(capacity):
            days = 1
            current_weight = 0
            for weight in weights:
                current_weight += weight
                if current_weight > capacity:
                    days += 1
                    current_weight = weight
                    if days > D:
                        return False
            return True

        left, right = max(weights), sum(weights)
        while left < right:
            mid = (left + right) // 2
            if canShip(mid):
                right = mid
            else:
                left = mid + 1
        return left