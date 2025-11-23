import heapq

class Solution:
    def minimumTime(self, grid: list[list[int]]) -> int:
        rows = len(grid)
        cols = len(grid[0])

        # If it's impossible to reach (0,0) or (0,1) or (1,0) directly
        # This condition is specific to a variant where you might need to "wait"
        # If grid[0][1] > 1 and grid[1][0] > 1, it implies you cannot move
        # to an adjacent cell if its time is too high initially.
        # This check is for a specific LeetCode problem 2812 "Find the Safest Path in a Grid"
        # or a similar one where initial moves are restricted.
        # However, for a generic "minimum time to reach last room", this check might not be needed.
        # Let's assume a standard Dijkstra where you can always move if within bounds.
        # If grid[0][0] is the cost to *enter* the cell, then the time starts there.
        # For problem 2812, the logic is more complex, involving a "safeness factor".
        # The title "Find Minimum Time to Reach Last Room I" is not standard.
        # I'll provide a standard Dijkstra for a grid where grid[r][c] is the time cost to *occupy* cell (r,c).

        # dist[r][c] stores the minimum time to reach (r, c)
        dist = [[float('inf')] * cols for _ in range(rows)]

        # Priority queue: (current_total_time, r, c)
        # The time at (0,0) is grid[0][0]
        # For some problems, the time starts at 0 and grid[0][0] is the cost to move *into* (0,0).
        # Assuming grid[r][c] is the time spent *in* cell (r,c) after reaching it.
        # So, the time to reach (0,0) is grid[0][0].
        dist[0][0] = grid[0][0]
        pq = [(grid[0][0], 0, 0)]

        # Directions: (dr, dc) for up, down, left, right
        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        while pq:
            current_time, r, c = heapq.heappop(pq)

            # If we already found a shorter path to (r, c), skip
            if current_time > dist[r][c]:
                continue

            # If we reached the destination
            if r == rows - 1 and c == cols - 1:
                return current_time

            for dr, dc in directions:
                nr, nc = r + dr, c + dc

                # Check bounds
                if 0 <= nr < rows and 0 <= nc < cols:
                    # The time to reach (nr, nc) is current_time + grid[nr][nc]
                    # This assumes grid[nr][nc] is the cost to enter/stay in (nr,nc)
                    new_time = current_time + grid[nr][nc]

                    if new_time < dist[nr][nc]:
                        dist[nr][nc] = new_time
                        heapq.heappush(pq, (new_time, nr, nc))

        # If destination is unreachable (e.g., no path exists)
        return -1