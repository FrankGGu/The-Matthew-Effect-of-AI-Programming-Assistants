class Solution:
    def temperatureTrend(self, temperatureA: List[int], temperatureB: List[int]) -> int:
        trendA = []
        trendB = []
        for i in range(len(temperatureA) - 1):
            if temperatureA[i+1] > temperatureA[i]:
                trendA.append(1)
            elif temperatureA[i+1] < temperatureA[i]:
                trendA.append(-1)
            else:
                trendA.append(0)
        for i in range(len(temperatureB) - 1):
            if temperatureB[i+1] > temperatureB[i]:
                trendB.append(1)
            elif temperatureB[i+1] < temperatureB[i]:
                trendB.append(-1)
            else:
                trendB.append(0)

        max_len = 0
        curr_len = 0
        for i in range(len(trendA)):
            if trendA[i] == trendB[i]:
                curr_len += 1
            else:
                max_len = max(max_len, curr_len)
                curr_len = 0
        max_len = max(max_len, curr_len)
        return max_len