class Solution:
    def simulate(self, commands: List[int], obstacles: List[List[int]]) -> List[int]:
        x, y = 0, 0
        direction = 0
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        obstacles_set = set(map(tuple, obstacles))

        for command in commands:
            if command == -1:
                direction = (direction + 1) % 4
            elif command == -2:
                direction = (direction - 1) % 4
            else:
                for _ in range(command):
                    if (x + directions[direction][0], y + directions[direction][1]) in obstacles_set:
                        break
                    x += directions[direction][0]
                    y += directions[direction][1]

        return [x, y]