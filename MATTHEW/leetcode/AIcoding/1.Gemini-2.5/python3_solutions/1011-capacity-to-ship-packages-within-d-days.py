class Solution:
    def shipWithinDays(self, weights: list[int], days: int) -> int:
        def can_ship(capacity: int) -> bool:
            days_needed = 1
            current_weight = 0
            for weight in weights:
                if current_weight + weight <= capacity:
                    current_weight += weight
                else:
                    days_needed += 1
                    current_weight = weight
            return days_needed <= days

        low = max(weights)
        high = sum(weights)
        ans = high

        while low <= high:
            mid = (low + high) // 2
            if can_ship(mid):
                ans = mid
                high = mid - 1
            else:
                low = mid + 1

        return ans