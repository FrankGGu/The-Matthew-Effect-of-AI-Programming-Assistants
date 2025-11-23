class Solution:
    def minimumWhiteTiles(self, tiles: str, numCarpets: int, carpetLen: int) -> int:
        n = len(tiles)

        prefix_white = [0] * (n + 1)
        for i in range(n):
            prefix_white[i+1] = prefix_white[i] + (1 if tiles[i] == '1' else 0)

        # dp[i] will store the minimum white tiles in tiles[0...i-1]
        # using the current number of carpets (j)
        # prev_dp[i] will store the minimum white tiles in tiles[0...i-1]
        # using (j-1) carpets

        # Initialize prev_dp for j=0 carpets
        # dp[i][0] = prefix_white[i]
        prev_dp = [0] * (n + 1)
        for i in range(n + 1):
            prev_dp[i] = prefix_white[i]

        # Iterate for j from 1 to numCarpets
        for j in range(1, numCarpets + 1):
            curr_dp = [0] * (n + 1)
            # Base case: curr_dp[0] = 0 (no tiles, no white tiles)

            for i in range(1, n + 1):
                # Option 1: Don't cover tiles[i-1] with a new carpet
                # The minimum white tiles is dp[i-1][j] + (1 if tiles[i-1] is white else 0)
                option1 = curr_dp[i-1] + (1 if tiles[i-1] == '1' else 0)

                # Option 2: Cover tiles[i-1] with a new carpet
                # This carpet covers tiles from max(0, i-carpetLen) to i-1.
                # The remaining problem is dp[max(0, i-carpetLen)][j-1]
                # (minimum white tiles in tiles[0...max(0, i-carpetLen)-1] using j-1 carpets)

                # We need to access prev_dp for j-1 carpets
                option2 = prev_dp[max(0, i - carpetLen)]

                curr_dp[i] = min(option1, option2)

            prev_dp = curr_dp 

        return prev_dp[n]