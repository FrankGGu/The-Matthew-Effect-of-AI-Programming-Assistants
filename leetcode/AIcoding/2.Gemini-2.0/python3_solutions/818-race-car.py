from collections import deque

class Solution:
    def racecar(self, target: int) -> int:
        q = deque([(0, 1, 0)])
        visited = set([(0, 1)])

        while q:
            pos, speed, steps = q.popleft()

            if pos == target:
                return steps

            next_pos_a = pos + speed
            next_speed_a = speed * 2
            if abs(next_pos_a - target) < target * 2 and (next_pos_a, next_speed_a) not in visited:
                q.append((next_pos_a, next_speed_a, steps + 1))
                visited.add((next_pos_a, next_speed_a))

            next_speed_r = -1 if speed > 0 else 1
            if (pos, next_speed_r) not in visited:
                q.append((pos, next_speed_r, steps + 1))
                visited.add((pos, next_speed_r))