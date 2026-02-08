from collections import deque

class Solution:
    def minimumMoves(self, grid: List[List[int]]) -> int:
        n = len(grid)
        target = (n-1, n-2, n-1, n-1)
        queue = deque()
        queue.append((0, 0, 0, 1))
        visited = set()
        visited.add((0, 0, 0, 1))
        moves = 0

        while queue:
            for _ in range(len(queue)):
                x1, y1, x2, y2 = queue.popleft()
                if (x1, y1, x2, y2) == target:
                    return moves

                # Move right
                if y2 + 1 < n and grid[x2][y2+1] == 0:
                    if x1 == x2:  # horizontal
                        new_pos = (x1, y1+1, x2, y2+1)
                        if new_pos not in visited:
                            visited.add(new_pos)
                            queue.append(new_pos)
                    else:  # vertical
                        if y1 + 1 < n and grid[x1][y1+1] == 0:
                            new_pos = (x1, y1+1, x2, y2+1)
                            if new_pos not in visited:
                                visited.add(new_pos)
                                queue.append(new_pos)

                # Move down
                if x2 + 1 < n and grid[x2+1][y2] == 0:
                    if y1 == y2:  # vertical
                        new_pos = (x1+1, y1, x2+1, y2)
                        if new_pos not in visited:
                            visited.add(new_pos)
                            queue.append(new_pos)
                    else:  # horizontal
                        if x1 + 1 < n and grid[x1+1][y1] == 0:
                            new_pos = (x1+1, y1, x2+1, y2)
                            if new_pos not in visited:
                                visited.add(new_pos)
                                queue.append(new_pos)

                # Rotate clockwise
                if x1 == x2 and x1 + 1 < n and y1 + 1 < n:
                    if grid[x1+1][y1] == 0 and grid[x2+1][y2] == 0:
                        new_pos = (x1, y1, x1+1, y1)
                        if new_pos not in visited:
                            visited.add(new_pos)
                            queue.append(new_pos)

                # Rotate counter-clockwise
                if y1 == y2 and y1 + 1 < n and x1 + 1 < n:
                    if grid[x1][y1+1] == 0 and grid[x2][y2+1] == 0:
                        new_pos = (x1, y1, x1, y1+1)
                        if new_pos not in visited:
                            visited.add(new_pos)
                            queue.append(new_pos)

            moves += 1

        return -1