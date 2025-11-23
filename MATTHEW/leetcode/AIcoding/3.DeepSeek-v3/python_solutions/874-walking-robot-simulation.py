class Solution:
    def robotSim(self, commands: List[int], obstacles: List[List[int]]) -> int:
        obstacles_set = set(map(tuple, obstacles))
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        x, y = 0, 0
        direction = 0
        max_distance = 0

        for cmd in commands:
            if cmd == -2:
                direction = (direction - 1) % 4
            elif cmd == -1:
                direction = (direction + 1) % 4
            else:
                dx, dy = directions[direction]
                for _ in range(cmd):
                    nx, ny = x + dx, y + dy
                    if (nx, ny) in obstacles_set:
                        break
                    x, y = nx, ny
                max_distance = max(max_distance, x*x + y*y)

        return max_distance