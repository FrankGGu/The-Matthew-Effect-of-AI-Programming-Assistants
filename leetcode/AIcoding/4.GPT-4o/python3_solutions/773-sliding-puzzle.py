from collections import deque

class Solution:
    def slidingPuzzle(self, board: List[List[int]]) -> int:
        start = ''.join(map(str, sum(board, [])))
        target = '123450'
        directions = [(1, 0), (-1, 0), (0, 1), (0, -1)]
        zero_index = start.index('0')

        def get_neighbors(index):
            neighbors = []
            row, col = divmod(index, 3)
            for dr, dc in directions:
                r, c = row + dr, col + dc
                if 0 <= r < 2 and 0 <= c < 3:
                    neighbors.append(r * 3 + c)
            return neighbors

        queue = deque([(start, zero_index, 0)])
        visited = {start}

        while queue:
            current, zero_index, steps = queue.popleft()
            if current == target:
                return steps
            for neighbor in get_neighbors(zero_index):
                new_board = list(current)
                new_board[zero_index], new_board[neighbor] = new_board[neighbor], new_board[zero_index]
                new_state = ''.join(new_board)
                if new_state not in visited:
                    visited.add(new_state)
                    queue.append((new_state, neighbor, steps + 1))

        return -1