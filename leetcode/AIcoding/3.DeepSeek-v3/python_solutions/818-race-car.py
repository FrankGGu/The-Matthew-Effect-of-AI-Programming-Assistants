from collections import deque

class Solution:
    def racecar(self, target: int) -> int:
        queue = deque()
        queue.append((0, 1))  # (position, speed)
        visited = set()
        visited.add((0, 1))
        steps = 0

        while queue:
            for _ in range(len(queue)):
                pos, speed = queue.popleft()
                if pos == target:
                    return steps
                # A指令
                new_pos = pos + speed
                new_speed = speed * 2
                if (new_pos, new_speed) not in visited and abs(new_pos - target) < target * 2:
                    visited.add((new_pos, new_speed))
                    queue.append((new_pos, new_speed))
                # R指令
                new_speed = -1 if speed > 0 else 1
                if (pos, new_speed) not in visited:
                    visited.add((pos, new_speed))
                    queue.append((pos, new_speed))
            steps += 1

        return -1