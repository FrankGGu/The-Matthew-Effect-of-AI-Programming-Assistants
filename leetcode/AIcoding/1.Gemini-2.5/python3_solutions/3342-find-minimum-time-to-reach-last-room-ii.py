import heapq

class Solution:
    def minimumTime(self, rooms: list[list[int]]) -> int:
        m, n = len(rooms), len(rooms[0])

        if m == 1 and n == 1:
            return 0

        # Check if it's possible to make the first move from (0,0)
        # You are at (0,0) at time 0.
        # To move to (0,1), you arrive at time 1. You need rooms[0][1] <= 1.
        # To move to (1,0), you arrive at time 1. You need rooms[1][0] <= 1.
        # If neither is possible, return -1.
        possible_first_move = False
        if n > 1 and rooms[0][1] <= 1:
            possible_first_move = True
        if m > 1 and rooms[1][0] <= 1:
            possible_first_move = True

        if not possible_first_move:
            return -1

        dist = [[float('inf')] * n for _ in range(m)]

        # Priority queue stores (current_time, r, c)
        pq = [(0, 0, 0)] # Start at (0,0) at time 0
        dist[0][0] = 0

        dr = [-1, 1, 0, 0]
        dc = [0, 0, -1, 1]

        while pq:
            current_time, r, c = heapq.heappop(pq)

            if current_time > dist[r][c]:
                continue

            if r == m - 1 and c == n - 1:
                return current_time

            for i in range(4):
                nr, nc = r + dr[i], c + dc[i]

                if 0 <= nr < m and 0 <= nc < n:
                    # Time to arrive at (nr, nc) if we move now
                    arrival_time = current_time + 1

                    # Determine the actual time we can be at (nr, nc)
                    # based on the room's entry requirement and parity rule.
                    if arrival_time >= rooms[nr][nc]:
                        next_time = arrival_time
                    else: # arrival_time < rooms[nr][nc], must wait
                        wait_needed = rooms[nr][nc] - arrival_time
                        if wait_needed % 2 == 1:
                            next_time = rooms[nr][nc]
                        else: # wait_needed % 2 == 0, must wait an extra unit to align parity
                            next_time = rooms[nr][nc] + 1

                    if next_time < dist[nr][nc]:
                        dist[nr][nc] = next_time
                        heapq.heappush(pq, (next_time, nr, nc))

        return -1