from collections import deque

class Solution:
    def slidingPuzzle(self, board: list[list[int]]) -> int:

        start_state = "".join(str(x) for row in board for x in row)
        target_state = "123450"

        adj = {
            0: [1, 3],
            1: [0, 2, 4],
            2: [1, 5],
            3: [0, 4],
            4: [1, 3, 5],
            5: [2, 4]
        }

        queue = deque([(start_state, 0)])
        visited = {start_state}

        while queue:
            current_state, moves = queue.popleft()

            if current_state == target_state:
                return moves

            zero_idx = current_state.find('0')

            for neighbor_idx in adj[zero_idx]:
                state_list = list(current_state)

                state_list[zero_idx], state_list[neighbor_idx] = state_list[neighbor_idx], state_list[zero_idx]

                next_state = "".join(state_list)

                if next_state not in visited:
                    visited.add(next_state)
                    queue.append((next_state, moves + 1))

        return -1