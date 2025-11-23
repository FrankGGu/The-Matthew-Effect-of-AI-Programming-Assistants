class Solution:
    def minOperations(self, x: int, y: int, z: int) -> int:
        from collections import deque

        visited = set()
        queue = deque([(x, 0)])
        visited.add(x)

        while queue:
            current, steps = queue.popleft()
            if current == y:
                return steps
            for next_val in [current + z, current - z, current * z]:
                if next_val not in visited and next_val >= 0:
                    visited.add(next_val)
                    queue.append((next_val, steps + 1))
        return -1