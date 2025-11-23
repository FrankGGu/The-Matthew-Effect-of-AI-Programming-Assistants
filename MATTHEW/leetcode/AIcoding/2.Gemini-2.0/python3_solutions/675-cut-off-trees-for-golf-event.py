import heapq

class Solution:
    def cutOffTree(self, forest):
        trees = []
        for r in range(len(forest)):
            for c in range(len(forest[0])):
                if forest[r][c] > 1:
                    trees.append((forest[r][c], r, c))
        trees.sort()

        sr, sc = 0, 0
        total_steps = 0

        for height, tr, tc in trees:
            steps = self.bfs(forest, sr, sc, tr, tc)
            if steps == -1:
                return -1
            total_steps += steps
            sr, sc = tr, tc

        return total_steps

    def bfs(self, forest, sr, sc, tr, tc):
        rows, cols = len(forest), len(forest[0])
        queue = [(0, sr, sc)]
        visited = set()
        visited.add((sr, sc))

        while queue:
            steps, r, c = heapq.heappop(queue)

            if r == tr and c == tc:
                return steps

            for dr, dc in [(0, 1), (0, -1), (1, 0), (-1, 0)]:
                nr, nc = r + dr, c + dc
                if 0 <= nr < rows and 0 <= nc < cols and forest[nr][nc] > 0 and (nr, nc) not in visited:
                    heapq.heappush(queue, (steps + 1, nr, nc))
                    visited.add((nr, nc))

        return -1