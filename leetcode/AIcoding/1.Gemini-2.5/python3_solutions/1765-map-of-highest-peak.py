import collections

class Solution:
    def highestPeak(self, isWater: list[list[int]]) -> list[list[int]]:
        m, n = len(isWater), len(isWater[0])
        heights = [[-1] * n for _ in range(m)]
        queue = collections.deque()

        for r in range(m):
            for c in range(n):
                if isWater[r][c] == 0:
                    heights[r][c] = 0
                    queue.append((r, c))

        directions = [(0, 1), (0, -1), (1, 0), (-1, 0)]

        while queue:
            r, c = queue.popleft()
            current_height = heights[r][c]

            for dr, dc in directions:
                nr, nc = r + dr, c + dc

                if 0 <= nr < m and 0 <= nc < n and heights[nr][nc] == -1:
                    heights[nr][nc] = current_height + 1
                    queue.append((nr, nc))

        return heights