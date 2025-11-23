import heapq

class Solution:
    def swimInRisingWater(self, grid: List[List[int]]) -> int:
        n = len(grid)

        # dist[r][c] stores the minimum 't' required to reach (r, c)
        # where 't' is the maximum elevation encountered on the path.
        dist = [[float('inf')] * n for _ in range(n)]

        # Priority queue stores tuples: (max_elevation_on_path, row, col)
        # We start at (0,0), and the time required to be there is its own elevation.
        pq = [(grid[0][0], 0, 0)]
        dist[0][0] = grid[0][0]

        # Directions for neighbors: up, down, left, right
        dr = [-1, 1, 0, 0]
        dc = [0, 0, -1, 1]

        while pq:
            current_max_time, r, c = heapq.heappop(pq)

            # If we've already found a better path to (r, c), skip
            if current_max_time > dist[r][c]:
                continue

            # If we reached the destination, this is the minimum max_elevation_on_path
            if r == n - 1 and c == n - 1:
                return current_max_time

            # Explore neighbors
            for i in range(4):
                nr, nc = r + dr[i], c + dc[i]

                # Check bounds
                if 0 <= nr < n and 0 <= nc < n:
                    # The time to reach (nr, nc) is the maximum of:
                    # 1. The current_max_time to reach (r, c)
                    # 2. The elevation of the new cell (nr, nc)
                    new_max_time = max(current_max_time, grid[nr][nc])

                    # If this path is better than what we've found before
                    if new_max_time < dist[nr][nc]:
                        dist[nr][nc] = new_max_time
                        heapq.heappush(pq, (new_max_time, nr, nc))

        # This part should ideally not be reached if a path always exists,
        # which is guaranteed by the problem constraints.
        return -1