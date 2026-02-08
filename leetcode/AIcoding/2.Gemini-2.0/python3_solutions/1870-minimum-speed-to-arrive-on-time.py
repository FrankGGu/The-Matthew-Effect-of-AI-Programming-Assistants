import math

class Solution:
    def minSpeedOnTime(self, dist: list[int], hour: float) -> int:
        n = len(dist)
        if n - 1 >= hour:
            return -1

        l, r = 1, 10**7
        ans = -1

        while l <= r:
            mid = (l + r) // 2
            time = 0
            for i in range(n - 1):
                time += math.ceil(dist[i] / mid)
            time += dist[n - 1] / mid

            if time <= hour:
                ans = mid
                r = mid - 1
            else:
                l = mid + 1

        return ans