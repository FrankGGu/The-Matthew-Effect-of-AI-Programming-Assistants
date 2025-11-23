class Solution:
    def racecar(self, target: int) -> int:
        from collections import deque

        queue = deque([(0, 1, 0)])  # position, speed, steps
        visited = set()

        while queue:
            pos, speed, steps = queue.popleft()
            if pos == target:
                return steps
            if (pos, speed) in visited:
                continue
            visited.add((pos, speed))

            # Accelerate
            next_pos = pos + speed
            next_speed = speed * 2
            queue.append((next_pos, next_speed, steps + 1))

            # Reverse
            next_pos = pos
            next_speed = -1 if speed > 0 else 1
            queue.append((next_pos, next_speed, steps + 1))