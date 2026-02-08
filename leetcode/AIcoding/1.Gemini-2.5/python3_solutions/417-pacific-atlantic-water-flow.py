import collections

class Solution:
    def pacificAtlantic(self, heights: list[list[int]]) -> list[list[int]]:
        m = len(heights)
        n = len(heights[0])

        pacific_reachable = set()
        atlantic_reachable = set()

        pacific_q = collections.deque()
        atlantic_q = collections.deque()

        # Initialize Pacific queue and reachable set (top row and left column)
        for r in range(m):
            pacific_q.append((r, 0))
            pacific_reachable.add((r, 0))
        for c in range(1, n): # Skip (0,0) as it's already added by the first loop
            pacific_q.append((0, c))
            pacific_reachable.add((0, c))

        # Initialize Atlantic queue and reachable set (bottom row and right column)
        for r in range(m):
            atlantic_q.append((r, n - 1))
            atlantic_reachable.add((r, n - 1))
        for c in range(n - 1): # Skip (m-1, n-1) as it's already added by the first loop
            atlantic_q.append((m - 1, c))
            atlantic_reachable.add((m - 1, c))

        def bfs(q, reachable_set):
            while q:
                r, c = q.popleft()

                for dr, dc in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
                    nr, nc = r + dr, c + dc

                    if 0 <= nr < m and 0 <= nc < n and (nr, nc) not in reachable_set and heights[nr][nc] >= heights[r][c]:
                        reachable_set.add((nr, nc))
                        q.append((nr, nc))

        bfs(pacific_q, pacific_reachable)
        bfs(atlantic_q, atlantic_reachable)

        result = []
        for r in range(m):
            for c in range(n):
                if (r, c) in pacific_reachable and (r, c) in atlantic_reachable:
                    result.append([r, c])

        return result