from collections import deque

class Solution:
    def slidingPuzzle(self, board: List[List[int]]) -> int:
        target = "123450"
        start = "".join(str(num) for row in board for num in row)
        if start == target:
            return 0

        q = deque([(start, 0)])
        visited = {start}
        neighbors = {
            0: [1, 3],
            1: [0, 2, 4],
            2: [1, 5],
            3: [0, 4],
            4: [1, 3, 5],
            5: [2, 4]
        }

        while q:
            curr, steps = q.popleft()
            zero_index = curr.index("0")

            for neighbor in neighbors[zero_index]:
                next_state = list(curr)
                next_state[zero_index], next_state[neighbor] = next_state[neighbor], next_state[zero_index]
                next_state = "".join(next_state)

                if next_state == target:
                    return steps + 1

                if next_state not in visited:
                    visited.add(next_state)
                    q.append((next_state, steps + 1))

        return -1