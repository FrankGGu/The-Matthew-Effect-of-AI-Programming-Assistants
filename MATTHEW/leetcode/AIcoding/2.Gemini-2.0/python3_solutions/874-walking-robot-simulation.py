class Solution:
    def robotSim(self, commands: list[int], obstacles: list[list[int]]) -> int:
        dx = [0, 1, 0, -1]
        dy = [1, 0, -1, 0]
        x = y = 0
        di = 0
        obstacles_set = set((x, y) for x, y in obstacles)
        ans = 0

        for command in commands:
            if command == -2:  # Turn left
                di = (di - 1) % 4
            elif command == -1:  # Turn right
                di = (di + 1) % 4
            else:  # Move forward command units
                for k in range(command):
                    if (x + dx[di], y + dy[di]) not in obstacles_set:
                        x += dx[di]
                        y += dy[di]
                        ans = max(ans, x*x + y*y)
                    else:
                        break

        return ans