class Solution:
    def findBall(self, grid: List[List[int]]) -> List[int]:
        m = len(grid)
        n = len(grid[0])

        result = []

        for start_col in range(n):
            curr_col = start_col

            for row in range(m):
                direction = grid[row][curr_col]

                next_col = curr_col + direction

                if next_col < 0 or next_col >= n:
                    curr_col = -1
                    break

                if grid[row][next_col] != direction:
                    curr_col = -1
                    break

                curr_col = next_col

            result.append(curr_col)

        return result