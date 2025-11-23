class Solution:
    def robotSim(self, commands: List[int], obstacles: List[List[int]]) -> int:
        obstacles_set = set(map(tuple, obstacles))
        direction = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        x = y = di = 0
        max_distance = 0

        for cmd in commands:
            if cmd == -2:  # turn left
                di = (di - 1) % 4
            elif cmd == -1:  # turn right
                di = (di + 1) % 4
            else:  # move forward
                for _ in range(cmd):
                    if (x + direction[di][0], y + direction[di][1]) not in obstacles_set:
                        x += direction[di][0]
                        y += direction[di][1]
                        max_distance = max(max_distance, x * x + y * y)
                    else:
                        break
        return max_distance