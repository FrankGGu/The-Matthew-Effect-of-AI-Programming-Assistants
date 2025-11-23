class Solution:
    def isRobotBounded(self, instructions: str) -> bool:
        x, y = 0, 0
        direction = 0  # 0: North, 1: East, 2: South, 3: West

        # Change in x and y for each direction
        # dx[0], dy[0] for North
        # dx[1], dy[1] for East
        # dx[2], dy[2] for South
        # dx[3], dy[3] for West
        dx = [0, 1, 0, -1]
        dy = [1, 0, -1, 0]

        for instruction in instructions:
            if instruction == 'G':
                x += dx[direction]
                y += dy[direction]
            elif instruction == 'L':
                direction = (direction + 3) % 4  # Turn left
            elif instruction == 'R':
                direction = (direction + 1) % 4  # Turn right

        # The robot is bounded in a circle if:
        # 1. It returns to the origin (0,0) after one cycle of instructions.
        # 2. It does not face North (direction != 0) after one cycle of instructions.
        #    If it faces any other direction, repeating the instructions will eventually
        #    bring it back to the origin or trace a closed loop.
        return (x == 0 and y == 0) or (direction != 0)