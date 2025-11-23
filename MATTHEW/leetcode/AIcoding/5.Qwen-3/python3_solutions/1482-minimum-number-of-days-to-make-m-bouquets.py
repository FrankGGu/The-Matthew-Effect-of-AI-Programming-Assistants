class Solution:
    def minDays(self, bloomDays: List[int], m: int, k: int) -> int:
        def canMake(days):
            bouquets = 0
            flowers = 0
            for day in bloomDays:
                if day > days:
                    flowers = 0
                else:
                    flowers += 1
                if flowers >= k:
                    bouquets += 1
                    flowers = 0
                if bouquets >= m:
                    return True
            return bouquets >= m

        left, right = 1, max(bloomDays)
        while left < right:
            mid = (left + right) // 2
            if canMake(mid):
                right = mid
            else:
                left = mid + 1
        return left