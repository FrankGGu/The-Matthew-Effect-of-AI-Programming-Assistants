class Solution:
    def moveRobot(self, instructions: str, x: int, y: int) -> bool:
        directions = [(0, 1), (1, 0), (0, -1), (-1, 0)]
        dir_idx = 0
        for ch in instructions:
            if ch == 'G':
                dx, dy = directions[dir_idx]
                x += dx
                y += dy
            elif ch == 'L':
                dir_idx = (dir_idx - 1) % 4
            elif ch == 'R':
                dir_idx = (dir_idx + 1) % 4
        return True