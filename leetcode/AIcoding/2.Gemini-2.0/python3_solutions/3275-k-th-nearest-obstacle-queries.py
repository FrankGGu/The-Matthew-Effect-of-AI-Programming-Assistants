import heapq

class Solution:
    def kthNearestObstacle(self, grid: List[List[int]], queries: List[List[int]]) -> List[int]:
        m, n = len(grid), len(grid[0])
        obstacles = []
        for i in range(m):
            for j in range(n):
                if grid[i][j] == 1:
                    obstacles.append((i, j))

        result = []
        for query in queries:
            row, col, k = query
            distances = []
            for obs_row, obs_col in obstacles:
                dist = abs(row - obs_row) + abs(col - obs_col)
                distances.append(dist)

            if not distances:
                result.append(-1)
                continue

            distances.sort()

            if k > len(distances):
                result.append(-1)
            else:
                kth_dist = distances[k-1]

                candidates = []
                for obs_row, obs_col in obstacles:
                    dist = abs(row - obs_row) + abs(col - obs_col)
                    if dist == kth_dist:
                        candidates.append((obs_row, obs_col))

                min_idx = -1
                min_dist = float('inf')

                for obs_row, obs_col in candidates:
                    idx = obstacles.index((obs_row, obs_col))
                    if idx < min_dist:
                        min_dist = idx
                        min_idx = idx

                if min_idx == -1:
                    result.append(-1)
                else:
                    result.append(min_idx)

        return result