class Solution:
    def minSpeedOnTime(self, dist: List[int], hour: float) -> int:
        def canArriveOnTime(speed: int) -> bool:
            time = 0.0
            for d in dist[:-1]:
                time += math.ceil(d / speed)
            time += dist[-1] / speed
            return time <= hour

        left, right = 1, 10**7
        result = -1

        while left <= right:
            mid = (left + right) // 2
            if canArriveOnTime(mid):
                result = mid
                right = mid - 1
            else:
                left = mid + 1

        return result