from collections import deque

class Solution:
    def slidingPuzzle(self, board: List[List[int]]) -> int:
        target = (1, 2, 3, 4, 5, 0)
        start = tuple(board[0] + board[1])
        if start == target:
            return 0

        moves = [
            [1, 3],
            [0, 2, 4],
            [1, 5],
            [0, 4],
            [1, 3, 5],
            [2, 4]
        ]

        visited = set()
        queue = deque([(start, 0)])
        visited.add(start)

        while queue:
            state, steps = queue.popleft()
            if state == target:
                return steps
            zero_pos = state.index(0)
            for move in moves[zero_pos]:
                new_state = list(state)
                new_state[zero_pos], new_state[move] = new_state[move], new_state[zero_pos]
                new_state_tuple = tuple(new_state)
                if new_state_tuple not in visited:
                    visited.add(new_state_tuple)
                    queue.append((new_state_tuple, steps + 1))

        return -1