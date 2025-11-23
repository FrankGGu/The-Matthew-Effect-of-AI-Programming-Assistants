class Solution:
    def temperatureTrend(self, temperatureA: list[int], temperatureB: list[int]) -> int:
        n = len(temperatureA)

        def get_trend(t1, t2):
            if t2 > t1:
                return 1
            elif t2 < t1:
                return -1
            else:
                return 0

        max_len = 0
        current_len = 0

        for i in range(n - 1):
            trendA = get_trend(temperatureA[i], temperatureA[i+1])
            trendB = get_trend(temperatureB[i], temperatureB[i+1])

            if trendA == trendB:
                current_len += 1
            else:
                current_len = 0

            max_len = max(max_len, current_len)

        return max_len