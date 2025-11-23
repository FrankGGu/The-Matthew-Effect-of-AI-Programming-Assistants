import heapq

class Solution:
    def minimumTime(self, grid: list[list[int]]) -> int:
        m, n = len(grid), len(grid[0])

        # Edge case: If already at the target cell (0,0)
        if m == 1 and n == 1:
            return 0

        # Special impossibility check for the first move from (0,0) at time 0.
        # According to the problem statement:
        # 1. "You are initially at cell (0, 0) at time 0."
        # 2. "You can move one cell per unit of time."
        # 3. "You can only enter cell (r', c') at time t' if t' >= grid[r'][c']."
        # This implies that from (0,0) at time 0, we must move to an adjacent cell
        # at time 1. If for all adjacent cells (nr, nc), the condition 1 >= grid[nr][nc]
        # is false (i.e., grid[nr][nc] > 1), then we cannot make a valid first move.
        # In such a scenario, it's impossible to proceed, and we should return -1.

        can_make_initial_move = False

        # Check if we can move to (0,1)
        if n > 1 and grid[0][1] <= 1:
            can_make_initial_move = True

        # Check if we can move to (1,0)
        if m > 1 and grid[1][0] <= 1:
            can_make_initial_move = True

        if not can_make_initial_move:
            return -1

        # Dijkstra's algorithm to find the shortest time path
        # dist[r][c] stores the minimum time to reach cell (r, c)
        dist = [[float('inf')] * n for _ in range(m)]

        # Priority queue stores tuples of (time, r, c)
        # It will always pop the path with the minimum time
        pq = []

        # Start at (0, 0) at time 0. The value grid[0][0] does not affect the starting time.
        dist[0][0] = 0
        heapq.heappush(pq, (0, 0, 0))

        # Directions for movement: right, left, down, up
        dr = [0, 0, 1, -1]
        dc = [1, -1, 0, 0]

        while pq:
            t, r, c = heapq.heappop(pq)

            # If we already found a shorter path to (r, c), skip this entry
            if t > dist[r][c]:
                continue

            # If we reached the target cell (m-1, n-1), return its time
            if r == m - 1 and c == n - 1:
                return t

            # Explore all four adjacent neighbors
            for i in range(4):
                nr, nc = r + dr[i], c + dc[i]

                # Check if the neighbor is within grid boundaries
                if 0 <= nr < m and 0 <= nc < n:
                    # Calculate the time to enter the neighbor cell (nr, nc).
                    # We arrive at (nr, nc) at time t + 1 (one unit of time for movement).
                    # However, we can only enter if t + 1 >= grid[nr][nc].
                    # If t + 1 < grid[nr][nc], we must wait until grid[nr][nc].
                    # So, the actual time we are at (nr, nc) is max(t + 1, grid[nr][nc]).
                    new_time = max(t + 1, grid[nr][nc])

                    # If this path offers a shorter time to reach (nr, nc), update and push to PQ
                    if new_time < dist[nr][nc]:
                        dist[nr][nc] = new_time
                        heapq.heappush(pq, (new_time, nr, nc))

        # If the priority queue becomes empty and the target cell was not reached,
        # it means the target is unreachable.
        return -1