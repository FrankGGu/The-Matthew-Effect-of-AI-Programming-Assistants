import collections

class Solution:
    def maximumSafenessFactor(self, grid: list[list[int]]) -> int:
        n = len(grid)

        dist = [[-1] * n for _ in range(n)]
        q = collections.deque()

        # Directions for BFS
        dr = [-1, 1, 0, 0]
        dc = [0, 0, -1, 1]

        # Step 1: Multi-source BFS to calculate safeness factor for all cells
        # Initialize queue with all thief locations and set their safeness to 0
        for r in range(n):
            for c in range(n):
                if grid[r][c] == 1:
                    dist[r][c] = 0
                    q.append((r, c))

        while q:
            r, c = q.popleft()

            for i in range(4):
                nr, nc = r + dr[i], c + dc[i]

                if 0 <= nr < n and 0 <= nc < n and dist[nr][nc] == -1:
                    dist[nr][nc] = dist[r][c] + 1
                    q.append((nr, nc))

        # Step 2: Binary search for the maximum possible safeness factor k
        low = 0
        high = 2 * (n - 1) # Max possible safeness factor (e.g., from one corner to the opposite)
        ans = 0

        def check(k: int) -> bool:
            # If the starting cell itself is not safe enough, no path exists
            if dist[0][0] < k:
                return False

            q_check = collections.deque()
            q_check.append((0, 0))
            visited = [[False] * n for _ in range(n)]
            visited[0][0] = True

            while q_check:
                r, c = q_check.popleft()

                if r == n - 1 and c == n - 1:
                    return True # Reached the destination

                for i in range(4):
                    nr, nc = r + dr[i], c + dc[i]

                    if 0 <= nr < n and 0 <= nc < n and not visited[nr][nc] and dist[nr][nc] >= k:
                        visited[nr][nc] = True
                        q_check.append((nr, nc))

            return False # Destination not reachable with this k

        while low <= high:
            mid = low + (high - low) // 2

            if check(mid):
                ans = mid
                low = mid + 1
            else:
                high = mid - 1

        return ans