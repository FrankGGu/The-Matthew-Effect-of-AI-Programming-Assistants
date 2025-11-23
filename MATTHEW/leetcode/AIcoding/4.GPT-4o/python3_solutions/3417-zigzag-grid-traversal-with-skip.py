class Solution:
    def zigzagTraversal(self, grid: List[List[int]]) -> List[int]:
        if not grid or not grid[0]:
            return []

        rows, cols = len(grid), len(grid[0])
        result = []
        direction = 1  # 1 for down-right, -1 for up-left

        for diag in range(rows + cols - 1):
            if direction == 1:
                for row in range(min(diag, rows - 1), max(-1, diag - cols), -1):
                    result.append(grid[row][diag - row])
            else:
                for row in range(max(0, diag - cols + 1), min(diag + 1, rows)):
                    result.append(grid[row][diag - row])
            direction *= -1

        return result