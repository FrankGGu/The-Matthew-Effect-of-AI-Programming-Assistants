class Solution:
    def findBall(self, grid: list[list[int]]) -> list[int]:
        m = len(grid)
        n = len(grid[0])

        answer = [-1] * n

        for start_col in range(n):
            current_col = start_col

            for row in range(m):
                direction = grid[row][current_col]
                next_col = current_col + direction

                if next_col < 0 or next_col >= n or grid[row][next_col] != direction:
                    current_col = -1
                    break

                current_col = next_col

            answer[start_col] = current_col

        return answer