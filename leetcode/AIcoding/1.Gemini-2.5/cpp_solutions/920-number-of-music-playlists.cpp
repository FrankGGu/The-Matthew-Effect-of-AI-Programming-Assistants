#include <vector>

class Solution {
public:
    int numMusicPlaylists(int n, int goal, int k) {
        long long MOD = 1e9 + 7;

        // dp[i][j] represents the number of playlists of length i using exactly j distinct songs.
        // i: current playlist length (up to goal)
        // j: number of unique songs used so far (up to n)
        std::vector<std::vector<long long>> dp(goal + 1, std::vector<long long>(n + 1, 0));

        // Base case: A playlist of length 0 uses 0 distinct songs. There's one way to do this (an empty playlist).
        dp[0][0] = 1;

        // Iterate through playlist lengths from 1 to goal
        for (int i = 1; i <= goal; ++i) {
            // Iterate through the number of unique songs from 1 to n
            for (int j = 1; j <= n; ++j) {
                // Case 1: The i-th song is a NEW song.
                // To form this, we must have had a playlist of length i-1 with j-1 unique songs.
                // We then pick one of the (n - (j-1)) remaining new songs.
                dp[i][j] = (dp[i][j] + dp[i-1][j-1] * (n - (j-1))) % MOD;

                // Case 2: The i-th song is an OLD song (already played).
                // To form this, we must have had a playlist of length i-1 with j unique songs.
                // We then pick one of the j already played songs.
                // However, due to the 'k' rule, a song can only be replayed after 'k' other songs.
                // This means we can only choose from 'j - k' songs that are eligible for replay.
                // If j <= k, no song can be replayed yet, so this term is 0.
                if (j > k) {
                    dp[i][j] = (dp[i][j] + dp[i-1][j] * (j - k)) % MOD;
                }
            }
        }

        // The result is the number of playlists of length 'goal' using exactly 'n' distinct songs.
        return dp[goal][n];
    }
};