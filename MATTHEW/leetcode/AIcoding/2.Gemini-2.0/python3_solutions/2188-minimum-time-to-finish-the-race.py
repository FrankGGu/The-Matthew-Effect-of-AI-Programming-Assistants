import heapq

class Solution:
    def minimumFinishTime(self, tires, changeTime, numLaps):
        n = len(tires)
        max_time = min(tires[i][0] for i in range(n)) * numLaps + changeTime * (numLaps - 1)

        min_time = [float('inf')] * (numLaps + 1)
        min_time[0] = 0

        best_tire = [float('inf')] * (numLaps + 1)

        for i in range(n):
            time = 0
            lap_time = tires[i][0]

            for laps in range(1, numLaps + 1):
                time += lap_time
                if time > max_time:
                    break
                best_tire[laps] = min(best_tire[laps], time)
                lap_time *= tires[i][1]
                if lap_time > max_time:
                    break

        for i in range(1, numLaps + 1):
            for j in range(1, i + 1):
                min_time[i] = min(min_time[i], min_time[i - j] + best_tire[j] + changeTime)

        return min_time[numLaps] - changeTime