var numMusicPlaylists = function(N, L, K) {
    const MOD = 10**9 + 7;

    // dp[i][j] will store the number of playlists of length i using exactly j unique songs.
    const dp = Array(L + 1).fill(0).map(() => Array(N + 1).fill(0));

    // Base case: An empty playlist has length 0 and uses 0 unique songs.
    dp[0][0] = 1;

    for (let i = 1; i <= L; i++) { // i: current playlist length
        for (let j = 1; j <= N; j++) { // j: current number of unique songs used
            // Case 1: The i-th song is a new song (not played before).
            // To form a playlist of length i with j unique songs by adding a new song,
            // we must have had a playlist of length (i-1) with (j-1) unique songs.
            // There are (N - (j-1)) choices for this new song (N total songs, j-1 already used).
            dp[i][j] = (dp[i][j] + dp[i-1][j-1] * (N - (j-1))) % MOD;

            // Case 2: The i-th song is an old song (already played before).
            // To form a playlist of length i with j unique songs by adding an old song,
            // we must have had a playlist of length (i-1) with j unique songs.
            // Due to the K constraint, a song can only be played again after K other songs.
            // So, out of the j unique songs already played, (j - K) songs are available for replay.
            // This is only possible if j > K. If j <= K, all j songs are "recently played".
            if (j > K) {
                dp[i][j] = (dp[i][j] + dp[i-1][j] * (j - K)) % MOD;
            }
        }
    }

    // The problem requires every song to be played at least once,
    // which means we need exactly N unique songs in a playlist of length L.
    return dp[L][N];
};