class Solution:
    def kNearestObstacles(self, obstacles: List[List[int]], queries: List[List[int]]) -> List[int]:
        obstacles_set = set(tuple(obstacle) for obstacle in obstacles)
        results = []

        for x, y, k in queries:
            distances = []
            for ox, oy in obstacles_set:
                dist = (x - ox) ** 2 + (y - oy) ** 2
                distances.append(dist)
            distances.sort()
            results.append(int(distances[k-1] ** 0.5))

        return results