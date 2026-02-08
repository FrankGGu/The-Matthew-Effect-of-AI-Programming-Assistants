from collections import deque

class Solution:
    def minPushBox(self, grid: List[List[str]], start: List[int], target: List[int]) -> int:
        m, n = len(grid), len(grid[0])
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]

        def canMove(box, direction):
            x1, y1 = box
            x2, y2 = box[0] + direction[0], box[1] + direction[1]
            if not (0 <= x2 < m and 0 <= y2 < n) or grid[x2][y2] == '#':
                return False
            if (x1, y1) == (x2, y2):
                return False
            return self.bfs((x1, y1), (x2, y2))

        def bfs(start, box):
            q = deque([start])
            visited = set([start])
            while q:
                curr = q.popleft()
                if curr == box:
                    return True
                for d in directions:
                    next_pos = (curr[0] + d[0], curr[1] + d[1])
                    if (0 <= next_pos[0] < m and 0 <= next_pos[1] < n and
                        next_pos not in visited and grid[next_pos[0]][next_pos[1]] != '#'):
                        visited.add(next_pos)
                        q.append(next_pos)
            return False

        start_box = tuple(start)
        target_box = tuple(target)
        q = deque([(start_box, start, 0)])
        visited = set([(start_box, start)])

        while q:
            box, player, moves = q.popleft()
            if box == target_box:
                return moves
            for d in directions:
                new_box = (box[0] + d[0], box[1] + d[1])
                if canMove(box, d) and new_box not in visited:
                    visited.add((new_box, box))
                    q.append((new_box, box, moves + 1))

        return -1