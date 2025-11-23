class Solution {
    public int numMusicPlaylists(int n, int goal, int k) {
        long MOD = 1_000_000_007;

        // dp[i][j] represents the number of playlists of length i using j unique songs.
        long[][] dp = new long[goal + 1][n + 1];

        // Base case: An empty playlist of length 0 uses 0 unique songs.
        dp[0][0] = 1;

        for (int i = 1; i <= goal; i++) {
            for (int j = 1; j <= n; j++) {
                // Case 1: Add a new song.
                // To form a playlist of length 'i' with 'j' unique songs by adding a new song:
                // We must have had a playlist of length 'i-1' with 'j-1' unique songs.
                // The new song must be one of the (n - (j-1)) songs not yet used.
                dp[i][j] = (dp[i - 1][j - 1] * (n - (j - 1))) % MOD;

                // Case 2: Repeat an old song.
                // To form a playlist of length 'i' with 'j' unique songs by repeating an old song:
                // We must have had a playlist of length 'i-1' with 'j' unique songs.
                // The repeated song must be one of the 'j' unique songs already in the playlist.
                // Due to the 'k' constraint, the 'k' most recently played unique songs cannot be repeated.
                // So, there are (j - k) choices for an old song to repeat.
                // This is only possible if j > k.
                if (j > k) {
                    dp[i][j] = (dp[i][j] + (dp[i - 1][j] * (j - k))) % MOD;
                }
            }
        }

        return (int) dp[goal][n];
    }
}