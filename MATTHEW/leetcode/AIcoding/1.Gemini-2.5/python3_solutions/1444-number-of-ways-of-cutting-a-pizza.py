class Solution:
    def ways(self, pizza: list[str], k: int) -> int:
        R = len(pizza)
        C = len(pizza[0])
        MOD = 10**9 + 7

        # Precompute the number of apples in suffix subgrids
        # apples[r][c] stores the number of apples in pizza[r:R][c:C]
        apples = [[0] * (C + 1) for _ in range(R + 1)]
        for r in range(R - 1, -1, -1):
            for c in range(C - 1, -1, -1):
                apples[r][c] = (1 if pizza[r][c] == 'A' else 0) \
                               + apples[r + 1][c] \
                               + apples[r][c + 1] \
                               - apples[r + 1][c + 1]

        # dp[num_pieces][r][c] stores the number of ways to cut the sub-pizza
        # pizza[r:R][c:C] into num_pieces pieces.
        # num_pieces ranges from 1 to k+1 (since k is number of cuts, k+1 is number of pieces)
        dp = [[[0] * C for _ in range(R)] for _ in range(k + 1)]

        # Base case: num_pieces = 1 (0 cuts)
        # If a sub-pizza has at least one apple, there's 1 way to make it a single piece.
        for r in range(R):
            for c in range(C):
                if apples[r][c] > 0:
                    dp[0][r][c] = 1 # dp[0] means 1 piece (0 cuts)

        # Iterate for num_pieces from 2 up to k+1 (which corresponds to dp[1] to dp[k])
        for num_cuts_made in range(1, k): # num_cuts_made is the current number of cuts
            for r in range(R - 1, -1, -1):
                for c in range(C - 1, -1, -1):
                    # If the current sub-pizza has no apples, it cannot be cut into any pieces
                    # such that each piece has at least one apple.
                    if apples[r][c] == 0:
                        continue

                    # Try all possible horizontal cuts
                    # The first piece is pizza[r:next_r][c:C]
                    # The remaining pizza is pizza[next_r:R][c:C]
                    for next_r in range(r + 1, R):
                        # Check if the first piece (pizza[r:next_r][c:C]) has at least one apple
                        if apples[r][c] - apples[next_r][c] > 0:
                            # Add ways to cut the remaining pizza into (num_cuts_made) pieces
                            dp[num_cuts_made][r][c] = (dp[num_cuts_made][r][c] + dp[num_cuts_made - 1][next_r][c]) % MOD

                    # Try all possible vertical cuts
                    # The first piece is pizza[r:R][c:next_c]
                    # The remaining pizza is pizza[r:R][next_c:C]
                    for next_c in range(c + 1, C):
                        # Check if the first piece (pizza[r:R][c:next_c]) has at least one apple
                        if apples[r][c] - apples[r][next_c] > 0:
                            # Add ways to cut the remaining pizza into (num_cuts_made) pieces
                            dp[num_cuts_made][r][c] = (dp[num_cuts_made][r][c] + dp[num_cuts_made - 1][r][next_c]) % MOD

        return dp[k - 1][0][0]