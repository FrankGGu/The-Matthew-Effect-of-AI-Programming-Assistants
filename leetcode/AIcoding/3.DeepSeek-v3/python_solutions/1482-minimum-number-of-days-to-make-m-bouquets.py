class Solution:
    def minDays(self, bloomDay: List[int], m: int, k: int) -> int:
        if m * k > len(bloomDay):
            return -1

        left, right = min(bloomDay), max(bloomDay)

        def canMakeBouquets(day):
            bouquets = 0
            flowers = 0
            for d in bloomDay:
                if d <= day:
                    flowers += 1
                    if flowers == k:
                        bouquets += 1
                        flowers = 0
                        if bouquets == m:
                            return True
                else:
                    flowers = 0
            return bouquets >= m

        while left < right:
            mid = (left + right) // 2
            if canMakeBouquets(mid):
                right = mid
            else:
                left = mid + 1
        return left