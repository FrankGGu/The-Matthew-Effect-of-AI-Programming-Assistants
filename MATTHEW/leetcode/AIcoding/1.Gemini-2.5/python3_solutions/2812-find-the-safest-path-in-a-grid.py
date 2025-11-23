import collections
import heapq

class Solution:
    def maximumSafenessFactor(self, grid: list[list[int]]) -> int:
        n = len(grid)

        # Step 1: Precompute safeness factors for all cells using multi-source BFS
        # safeness_grid[r][c] will store the Manhattan distance from (r,c) to the nearest thief.
        # Initialize with -1 to mark unvisited cells.
        safeness_grid = [[-1] * n for _ in range(n)]
        q = collections.deque()

        # Initialize BFS queue with all thief locations and set their safeness to 0.
        for r in range(n):
            for c in range(n):
                if grid[r][c] == 1: # Thief found
                    q.append((r, c))
                    safeness_grid[r][c] = 0

        # Directions for BFS: up, down, left, right
        dr = [-1, 1, 0, 0]
        dc = [0, 0, -1, 1]

        # Perform BFS to calculate safeness for all cells
        while q:
            r, c = q.popleft()

            for i in range(4):
                nr, nc = r + dr[i], c + dc[i]

                # If neighbor is within bounds and unvisited
                if 0 <= nr < n and 0 <= nc < n and safeness_grid[nr][nc] == -1:
                    safeness_grid[nr][nc] = safeness_grid[r][c] + 1
                    q.append((nr, nc))

        # Step 2: Find the path from (0,0) to (n-1,n-1) with the maximum minimum safeness.
        # This is a modified Dijkstra's algorithm (or Max-Heap BFS).

        # dist[r][c] stores the maximum minimum safeness found so far for any path
        # from (0,0) to (r,c). Initialize with -1 (or negative infinity).
        dist = [[-1] * n for _ in range(n)]

        # Max-heap to store (-safeness, r, c). We use negative safeness because
        # Python's heapq is a min-heap, and we want to prioritize higher safeness.
        pq = []

        # Start from (0,0). The initial minimum safeness for the path to (0,0) is
        # the safeness of (0,0) itself.
        heapq.heappush(pq, (-safeness_grid[0][0], 0, 0))
        dist[0][0] = safeness_grid[0][0]

        while pq:
            current_min_safeness_neg, r, c = heapq.heappop(pq)
            current_min_safeness = -current_min_safeness_neg # Convert back to positive

            # If we reached the target cell (n-1, n-1), this 'current_min_safeness'
            # is the maximum possible minimum safeness for any path to this cell.
            # Since Dijkstra explores in a best-first manner, this is our answer.
            if r == n - 1 and c == n - 1:
                return current_min_safeness

            # If we have already found a path to (r,c) with a higher or equal
            # minimum safeness, we don't need to explore from this state again.
            if current_min_safeness < dist[r][c]:
                continue

            # Explore neighbors
            for i in range(4):
                nr, nc = r + dr[i], c + dc[i]

                if 0 <= nr < n and 0 <= nc < n:
                    # The minimum safeness for a path going through (nr,nc) from (r,c)
                    # is the minimum of the path's current minimum safeness and the
                    # safeness of the new cell (nr,nc).
                    new_path_min_safeness = min(current_min_safeness, safeness_grid[nr][nc])

                    # If this new path offers a higher minimum safeness to (nr,nc)
                    # than any path found previously, update and push to heap.
                    if new_path_min_safeness > dist[nr][nc]:
                        dist[nr][nc] = new_path_min_safeness
                        heapq.heappush(pq, (-new_path_min_safeness, nr, nc))

        # This line should theoretically not be reached if a path always exists and N >= 1.
        # If (0,0) or (n-1,n-1) are thieves, their safeness is 0. The path can still exist.
        return 0