import math

class Solution:
    def minSpeedOnTime(self, dist: List[int], hour: float) -> int:
        left = 1
        right = 10**7
        answer = -1

        def is_possible(speed):
            total = 0.0
            for d in dist[:-1]:
                total += math.ceil(d / speed)
            total += dist[-1] / speed
            return total <= hour

        while left <= right:
            mid = (left + right) // 2
            if is_possible(mid):
                answer = mid
                right = mid - 1
            else:
                left = mid + 1

        return answer