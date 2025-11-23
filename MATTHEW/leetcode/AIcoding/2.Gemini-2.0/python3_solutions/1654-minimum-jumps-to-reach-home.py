from collections import deque

class Solution:
    def minimumJumps(self, forbidden: list[int], a: int, b: int, x: int) -> int:
        forbidden_set = set(forbidden)
        q = deque([(0, 0, False)])  # position, steps, can_go_back
        visited = set()
        visited.add((0, False))

        max_reach = max(x, max(forbidden) + a + b)

        while q:
            pos, steps, went_back = q.popleft()

            if pos == x:
                return steps

            # Forward jump
            next_pos = pos + a
            if 0 <= next_pos <= 2 * max_reach and next_pos not in forbidden_set and (next_pos, False) not in visited:
                q.append((next_pos, steps + 1, False))
                visited.add((next_pos, False))

            # Backward jump
            next_pos = pos - b
            if not went_back and 0 <= next_pos <= 2 * max_reach and next_pos not in forbidden_set and (next_pos, True) not in visited:
                q.append((next_pos, steps + 1, True))
                visited.add((next_pos, True))

        return -1