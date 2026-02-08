class Solution:
    def maxPower(self, stations: List[int], k: int) -> int:
        def canDistribute(minPower):
            total = 0
            for power in stations:
                if power < minPower:
                    total += minPower - power
            return total <= k

        left, right = 0, max(stations) + k
        while left < right:
            mid = (left + right + 1) // 2
            if canDistribute(mid):
                left = mid
            else:
                right = mid - 1
        return left