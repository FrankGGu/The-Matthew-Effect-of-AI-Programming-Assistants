class Solution:
    def shipWithinDays(self, weights: List[int], days: int) -> int:
        left = max(weights)
        right = sum(weights)

        while left < right:
            mid = (left + right) // 2
            current = 0
            required_days = 1

            for weight in weights:
                if current + weight > mid:
                    required_days += 1
                    current = 0
                current += weight

            if required_days > days:
                left = mid + 1
            else:
                right = mid

        return left