class Solution:
    def eliminateMaximum(self, dist: List[int], speed: List[int]) -> int:
        arrival_times = []
        for i in range(len(dist)):
            arrival_times.append((dist[i] + speed[i] - 1) // speed[i])

        arrival_times.sort()

        eliminated = 0
        time = 0

        for arrival_time in arrival_times:
            if arrival_time > time:
                eliminated += 1
                time += 1
            else:
                break

        return eliminated