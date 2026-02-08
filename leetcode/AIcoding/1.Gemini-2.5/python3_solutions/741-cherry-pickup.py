import math

class Solution:
    def cherryPickup(self, grid: list[list[int]]) -> int:
        N = len(grid)

        # dp[s][c1][c2] stores the maximum cherries collected
        # when both robots have taken 's' steps,
        # robot 1 is at (r1, c1) and robot 2 is at (r2, c2).
        # r1 = s - c1
        # r2 = s - c2
        # Initializing with -infinity to represent unreachable states.
        dp = [[[-math.inf] * N for _ in range(N)] for _ in range(2 * N - 1)]

        # Base case: both robots start at (0, 0)
        # If (0,0) is a thorn, it's impossible to start, so -inf.
        # Problem constraints state grid[0][0] is 0 or 1.
        dp[0][0][0] = grid[0][0]

        # Iterate through the total number of steps 's'
        # 's' goes from 0 to 2*N - 2 (max steps to reach (N-1, N-1))
        for s in range(1, 2 * N - 1):
            # Iterate through all possible column positions for robot 1
            for c1 in range(N):
                # Calculate row for robot 1
                r1 = s - c1

                # Check if robot 1's position (r1, c1) is valid and not a thorn
                if not (0 <= r1 < N and 0 <= c1 < N and grid[r1][c1] != -1):
                    continue

                # Iterate through all possible column positions for robot 2
                for c2 in range(N):
                    # Calculate row for robot 2
                    r2 = s - c2

                    # Check if robot 2's position (r2, c2) is valid and not a thorn
                    if not (0 <= r2 < N and 0 <= c2 < N and grid[r2][c2] != -1):
                        continue

                    # Calculate cherries collected at the current step
                    current_cherries = grid[r1][c1]
                    # If robots are at different cells, add cherries from robot 2's cell
                    if r1 != r2 or c1 != c2:
                        current_cherries += grid[r2][c2]

                    # Find the maximum cherries from previous states
                    # Both robots can move down (D) or right (R)
                    # Possible previous states (r1_prev, c1_prev) and (r2_prev, c2_prev):
                    # 1. R1 from (r1-1, c1), R2 from (r2-1, c2) -> Both moved Down (DD)
                    # 2. R1 from (r1-1, c1), R2 from (r2, c2-1) -> R1 Down, R2 Right (DR)
                    # 3. R1 from (r1, c1-1), R2 from (r2-1, c2) -> R1 Right, R2 Down (RD)
                    # 4. R1 from (r1, c1-1), R2 from (r2, c2-1) -> Both moved Right (RR)

                    prev_max_cherries = -math.inf

                    # Case 1: Both moved Down (DD)
                    if r1 > 0 and r2 > 0:
                        prev_max_cherries = max(prev_max_cherries, dp[s - 1][c1][c2])

                    # Case 2: R1 Down, R2 Right (DR)
                    if r1 > 0 and c2 > 0:
                        prev_max_cherries = max(prev_max_cherries, dp[s - 1][c1][c2 - 1])

                    # Case 3: R1 Right, R2 Down (RD)
                    if c1 > 0 and r2 > 0:
                        prev_max_cherries = max(prev_max_cherries, dp[s - 1][c1 - 1][c2])

                    # Case 4: Both moved Right (RR)
                    if c1 > 0 and c2 > 0:
                        prev_max_cherries = max(prev_max_cherries, dp[s - 1][c1 - 1][c2 - 1])

                    # If a valid previous state exists, update current state
                    if prev_max_cherries != -math.inf:
                        dp[s][c1][c2] = prev_max_cherries + current_cherries

        # The maximum cherries collected when both robots reach (N-1, N-1)
        # corresponds to dp[2*N-2][N-1][N-1].
        # If this state is unreachable (-math.inf), return 0 as per problem.
        return max(0, dp[2 * N - 2][N - 1][N - 1])