from collections import deque

class Solution:
    def minimumMoves(self, target: int) -> int:
        target = abs(target)
        queue = deque([(0, 0)])  # (position, moves)
        visited = set((0, 0))

        while queue:
            pos, moves = queue.popleft()
            if pos == target:
                return moves

            # Move forward
            new_pos = pos + (moves + 1)
            if new_pos <= target + (moves + 1) and (new_pos, moves + 1) not in visited:
                visited.add((new_pos, moves + 1))
                queue.append((new_pos, moves + 1))

            # Move backward
            new_pos = pos - (moves + 1)
            if new_pos >= -1 and (new_pos, moves + 1) not in visited:
                visited.add((new_pos, moves + 1))
                queue.append((new_pos, moves + 1))