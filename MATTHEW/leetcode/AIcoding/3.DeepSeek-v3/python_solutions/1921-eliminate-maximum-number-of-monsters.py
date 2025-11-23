class Solution:
    def eliminateMaximum(self, dist: List[int], speed: List[int]) -> int:
        n = len(dist)
        time_to_reach = [dist[i] / speed[i] for i in range(n)]
        time_to_reach.sort()

        eliminated = 0
        for i in range(n):
            if time_to_reach[i] <= i:
                break
            eliminated += 1

        return eliminated