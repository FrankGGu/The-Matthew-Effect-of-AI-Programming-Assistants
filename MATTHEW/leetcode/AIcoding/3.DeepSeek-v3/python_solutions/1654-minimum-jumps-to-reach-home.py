from collections import deque

class Solution:
    def minimumJumps(self, forbidden: List[int], a: int, b: int, x: int) -> int:
        max_limit = 2000 + a + b
        forbidden_set = set(forbidden)
        visited = set()
        queue = deque()
        queue.append((0, 0, True))  # (position, jumps, can_back_jump)
        visited.add((0, True))
        visited.add((0, False))

        while queue:
            pos, jumps, can_back = queue.popleft()
            if pos == x:
                return jumps
            # Forward jump
            forward_pos = pos + a
            if forward_pos <= max_limit and forward_pos not in forbidden_set and (forward_pos, True) not in visited:
                visited.add((forward_pos, True))
                queue.append((forward_pos, jumps + 1, True))
            # Backward jump
            if can_back:
                backward_pos = pos - b
                if backward_pos >= 0 and backward_pos not in forbidden_set and (backward_pos, False) not in visited:
                    visited.add((backward_pos, False))
                    queue.append((backward_pos, jumps + 1, False))
        return -1