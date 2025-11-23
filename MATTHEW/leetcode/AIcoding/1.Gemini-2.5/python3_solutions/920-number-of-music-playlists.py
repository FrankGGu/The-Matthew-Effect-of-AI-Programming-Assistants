class Solution:
    def numMusicPlaylists(self, n: int, goal: int, k: int) -> int:
        MOD = 10**9 + 7

        # dp[i][j] will store the number of playlists of length i using j unique songs.
        # i: current playlist length (up to goal)
        # j: number of unique songs used (up to n)
        dp = [[0] * (n + 1) for _ in range(goal + 1)]

        # Base case: An empty playlist of length 0 uses 0 unique songs.
        dp[0][0] = 1

        for i in range(1, goal + 1):
            # The number of unique songs 'j' cannot exceed the playlist length 'i'
            # and cannot exceed the total number of available songs 'n'.
            for j in range(1, min(i, n) + 1): 
                # Case 1: The i-th song is a new song.
                # We must have used j-1 unique songs in the first i-1 positions.
                # There are (n - (j-1)) choices for this new song from the remaining available songs.
                # (n - (j-1)) is the count of songs not yet used.
                dp[i][j] = (dp[i][j] + dp[i-1][j-1] * (n - (j-1))) % MOD

                # Case 2: The i-th song is a repeated song.
                # We must have used j unique songs in the first i-1 positions.
                # For a song to be repeated, it must not have been played in the last k songs.
                # So, there are (j - k) choices for the repeated song.
                # If j <= k, then no song can be repeated, so this term is 0.
                if j > k:
                    dp[i][j] = (dp[i][j] + dp[i-1][j] * (j - k)) % MOD

        return dp[goal][n]