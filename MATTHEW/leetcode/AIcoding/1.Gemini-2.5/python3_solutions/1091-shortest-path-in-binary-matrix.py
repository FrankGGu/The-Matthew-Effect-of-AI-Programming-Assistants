import collections

class Solution:
    def shortestPathBinaryMatrix(self, grid: list[list[int]]) -> int:
        n = len(grid)

        if grid[0][0] == 1 or grid[n-1][n-1] == 1:
            return -1

        # Queue stores (row, col, distance)
        q = collections.deque([(0, 0, 1)])

        # Mark the starting cell as visited by changing its value
        # This also stores the distance to the cell.
        grid[0][0] = 1 

        directions = [
            (-1, -1), (-1, 0), (-1, 1),
            (0, -1),           (0, 1),
            (1, -1), (1, 0), (1, 1)
        ]

        while q:
            r, c, dist = q.popleft()

            # If we reached the target cell
            if r == n - 1 and c == n - 1:
                return dist

            for dr, dc in directions:
                nr, nc = r + dr, c + dc

                # Check bounds and if the cell is traversable (value 0)
                if 0 <= nr < n and 0 <= nc < n and grid[nr][nc] == 0:
                    grid[nr][nc] = dist + 1  # Mark as visited and store distance
                    q.append((nr, nc, dist + 1))

        # If the queue becomes empty and target was not reached
        return -1