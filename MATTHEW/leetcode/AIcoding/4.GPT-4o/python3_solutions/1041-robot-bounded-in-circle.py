class Solution:
    def isRobotBounded(self, instructions: str) -> bool:
        direction = 0
        x, y = 0, 0
        for instruction in instructions:
            if instruction == 'G':
                if direction == 0:
                    y += 1
                elif direction == 1:
                    x += 1
                elif direction == 2:
                    y -= 1
                else:
                    x -= 1
            elif instruction == 'L':
                direction = (direction + 3) % 4
            else:
                direction = (direction + 1) % 4

        return (x == 0 and y == 0) or direction != 0