from collections import deque

class Solution:
    def minimumJumps(self, forbidden: List[int], a: int, b: int, x: int) -> int:
        forbidden_set = set(forbidden)
        max_pos = max(max(forbidden, default=0) + a + b, x + a + b)
        queue = deque([(0, 0, True)])  # (current_position, jumps, can_jump_back)
        visited = set((0, True))

        while queue:
            position, jumps, can_jump_back = queue.popleft()
            if position == x:
                return jumps

            forward = position + a
            if forward <= max_pos and forward not in forbidden_set and (forward, True) not in visited:
                visited.add((forward, True))
                queue.append((forward, jumps + 1, True))

            if can_jump_back:
                backward = position - b
                if 0 <= backward <= max_pos and backward not in forbidden_set and (backward, False) not in visited:
                    visited.add((backward, False))
                    queue.append((backward, jumps + 1, False))

        return -1