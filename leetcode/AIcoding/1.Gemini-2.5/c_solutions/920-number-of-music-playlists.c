#define MOD 1000000007

int numMusicPlaylists(int n, int l, int k) {
    // dp[i][j] will store the number of playlists of length i using j unique songs
    // The table size is (l+1) x (n+1)
    long long dp[l + 1][n + 1];

    // Initialize dp table with 0s
    for (int i = 0; i <= l; i++) {
        for (int j = 0; j <= n; j++) {
            dp[i][j] = 0;
        }
    }

    // Base case: An empty playlist has length 0 and 0 unique songs
    dp[0][0] = 1;

    // Fill the dp table
    for (int i = 1; i <= l; i++) { // Current playlist length
        for (int j = 1; j <= n; j++) { // Number of unique songs used so far

            // Case 1: The i-th song added is a new song
            // We must have used j-1 unique songs in the playlist of length i-1.
            // There are (n - (j-1)) new songs available to choose from.
            dp[i][j] = (dp[i][j] + dp[i-1][j-1] * (n - (j-1))) % MOD;

            // Case 2: The i-th song added is an old song (already played)
            // We must have used j unique songs in the playlist of length i-1.
            // To repeat a song, it must have been played more than k songs ago.
            // This means there are (j - k) songs that are eligible to be repeated.
            // If j <= k, then (j - k) <= 0, so no song can be repeated.
            if (j > k) {
                dp[i][j] = (dp[i][j] + dp[i-1][j] * (j - k)) % MOD;
            }
        }
    }

    // The final result is the number of playlists of length L using exactly N unique songs
    return (int)dp[l][n];
}