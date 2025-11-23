class Solution:
    def shipWithinDays(self, weights: list[int], days: int) -> int:
        def possible(capacity):
            day = 1
            current_weight = 0
            for weight in weights:
                if current_weight + weight > capacity:
                    day += 1
                    current_weight = 0
                current_weight += weight
            return day <= days

        left, right = max(weights), sum(weights)
        while left < right:
            mid = (left + right) // 2
            if possible(mid):
                right = mid
            else:
                left = mid + 1
        return left