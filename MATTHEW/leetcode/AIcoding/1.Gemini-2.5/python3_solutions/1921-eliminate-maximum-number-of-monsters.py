class Solution:
    def eliminateMaximumMonsters(self, dist: list[int], speed: list[int]) -> int:
        n = len(dist)

        arrival_times = []
        for i in range(n):
            arrival_times.append(dist[i] / speed[i])

        arrival_times.sort()

        eliminated_count = 0
        for i in range(n):
            # The i-th monster (0-indexed in the sorted list) is the (i+1)-th monster we attempt to eliminate.
            # We are ready to eliminate the (i+1)-th monster at minute 'i'.
            # If this monster arrives at or before minute 'i', we lose.
            if arrival_times[i] <= i:
                return eliminated_count

            eliminated_count += 1

        return n