class Solution:
    def pathsWithMaxScore(self, board: list[str]) -> list[int]:
        n = len(board)

        # dp[r][c] stores (max_score, num_paths) to reach (r, c)
        # Initialize with (-1, 0) to indicate unreachable or no path yet.
        # -1 for score ensures that 0 is a valid score and can be compared properly.
        # 0 for num_paths means no paths found yet.
        dp = [[(-1, 0)] * n for _ in range(n)]

        MOD = 10**9 + 7

        # Base case: Starting cell 'E' at (0, 0)
        # Score is 0 (as 'E' is excluded from sum), 1 path to itself.
        dp[0][0] = (0, 1)

        # Iterate through the board from top-left to bottom-right
        for r in range(n):
            for c in range(n):
                # Skip if current cell is an obstacle 'X'
                if board[r][c] == 'X':
                    continue

                # Skip the starting cell 'E' as its base case is already handled
                if r == 0 and c == 0:
                    continue

                # Determine the numeric value of the current cell
                # 'S' has a value of 0. Digits '0'-'9' have their numeric value.
                current_val = 0
                if board[r][c] != 'S':
                    current_val = int(board[r][c])

                # Collect scores and paths from valid previous cells
                # Possible moves are from (r-1, c) [up], (r, c-1) [left], (r-1, c-1) [up-left diagonal]

                max_prev_score = -1
                num_prev_paths = 0

                # Check path from top (r-1, c)
                if r > 0 and dp[r-1][c][0] != -1:
                    score, paths = dp[r-1][c]
                    if score > max_prev_score:
                        max_prev_score = score
                        num_prev_paths = paths
                    elif score == max_prev_score:
                        num_prev_paths = (num_prev_paths + paths) % MOD

                # Check path from left (r, c-1)
                if c > 0 and dp[r][c-1][0] != -1:
                    score, paths = dp[r][c-1]
                    if score > max_prev_score:
                        max_prev_score = score
                        num_prev_paths = paths
                    elif score == max_prev_score:
                        num_prev_paths = (num_prev_paths + paths) % MOD

                # Check path from top-left diagonal (r-1, c-1)
                if r > 0 and c > 0 and dp[r-1][c-1][0] != -1:
                    score, paths = dp[r-1][c-1]
                    if score > max_prev_score:
                        max_prev_score = score
                        num_prev_paths = paths
                    elif score == max_prev_score:
                        num_prev_paths = (num_prev_paths + paths) % MOD

                # If no valid path to current cell from any direction
                if max_prev_score == -1:
                    dp[r][c] = (-1, 0)
                else:
                    # Update current cell's max score and number of paths
                    # Add current_val to the max_prev_score
                    dp[r][c] = (max_prev_score + current_val, num_prev_paths)

        # The result is at the 'S' cell (N-1, N-1)
        final_score, final_paths = dp[n-1][n-1]

        # If no path exists to 'S' (indicated by -1 score), return [0, 0]
        if final_score == -1:
            return [0, 0]
        else:
            return [final_score, final_paths]