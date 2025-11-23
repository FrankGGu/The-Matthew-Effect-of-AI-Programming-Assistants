class Solution:
    def temperatureTrend(self, temperatureA: List[int], temperatureB: List[int]) -> int:
        n = len(temperatureA)
        res = 0
        current = 0

        for i in range(1, n):
            trendA = temperatureA[i] - temperatureA[i-1]
            trendB = temperatureB[i] - temperatureB[i-1]

            if (trendA > 0 and trendB > 0) or (trendA < 0 and trendB < 0) or (trendA == 0 and trendB == 0):
                current += 1
                res = max(res, current)
            else:
                current = 0

        return res