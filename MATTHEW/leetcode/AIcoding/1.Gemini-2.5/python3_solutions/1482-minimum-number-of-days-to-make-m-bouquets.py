class Solution:
    def minDays(self, bloomDay: list[int], m: int, k: int) -> int:
        if m * k > len(bloomDay):
            return -1

        def check(days_limit: int) -> bool:
            bouquets_count = 0
            current_flowers = 0
            for b_day in bloomDay:
                if b_day <= days_limit:
                    current_flowers += 1
                    if current_flowers == k:
                        bouquets_count += 1
                        current_flowers = 0
                else:
                    current_flowers = 0
            return bouquets_count >= m

        low = min(bloomDay)
        high = max(bloomDay)
        ans = -1

        while low <= high:
            mid = low + (high - low) // 2
            if check(mid):
                ans = mid
                high = mid - 1
            else:
                low = mid + 1

        return ans