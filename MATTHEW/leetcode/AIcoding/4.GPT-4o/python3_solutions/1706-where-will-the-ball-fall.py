class Solution:
    def findBall(self, grid: List[List[int]]) -> List[int]:
        rows, cols = len(grid), len(grid[0])
        result = []

        for col in range(cols):
            curr_col = col
            for row in range(rows):
                direction = grid[row][curr_col]
                next_col = curr_col + direction

                if next_col < 0 or next_col >= cols or grid[row][curr_col] != direction:
                    curr_col = -1
                    break
                curr_col = next_col

            result.append(curr_col)

        return result