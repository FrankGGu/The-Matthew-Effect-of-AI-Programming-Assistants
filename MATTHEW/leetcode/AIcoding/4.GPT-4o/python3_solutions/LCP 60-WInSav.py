class Solution:
    def findBall(self, grid: List[List[int]]) -> List[int]:
        rows, cols = len(grid), len(grid[0])
        result = []

        for col in range(cols):
            current_col = col

            for row in range(rows):
                direction = grid[row][current_col]
                next_col = current_col + direction

                if next_col < 0 or next_col >= cols or grid[row][next_col] != direction:
                    current_col = -1
                    break

                current_col = next_col

            result.append(current_col)

        return result