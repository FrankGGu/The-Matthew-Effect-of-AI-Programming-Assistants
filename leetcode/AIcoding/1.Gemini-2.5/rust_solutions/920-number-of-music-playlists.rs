impl Solution {
    pub fn num_music_playlists(n: i32, l: i32, k: i32) -> i32 {
        let n = n as usize;
        let l = l as usize;
        let k = k as usize;
        let modulo = 1_000_000_007;

        // dp[i][j] represents the number of playlists of length 'i' using exactly 'j' unique songs.
        // i: playlist length (0 to L)
        // j: number of unique songs (0 to N)
        let mut dp = vec![vec![0i64; n + 1]; l + 1];

        // Base case: An empty playlist (length 0) uses 0 unique songs, and there's 1 way to do this.
        dp[0][0] = 1;

        for i in 1..=l { // Iterate through playlist lengths from 1 to L
            for j in 1..=n { // Iterate through the number of unique songs from 1 to N
                // Case 1: The i-th song added is a new song.
                // To form a playlist of length 'i' with 'j' unique songs by adding a new song,
                // we must have had a playlist of length 'i-1' with 'j-1' unique songs.
                // There are (N - (j-1)) new songs available to pick from.
                // This term is only valid if j > 0 (i.e., j-1 is a valid index for unique songs).
                // (n - (j - 1)) is equivalent to (n - j + 1).
                dp[i][j] = (dp[i][j] + dp[i-1][j-1] * (n - j + 1) as i64) % modulo;

                // Case 2: The i-th song added is an old song (repeated).
                // To form a playlist of length 'i' with 'j' unique songs by repeating an old song,
                // we must have had a playlist of length 'i-1' with 'j' unique songs.
                // According to the problem, a song can only be repeated if it was played 'K' songs ago or earlier.
                // This means among the 'j' unique songs already played, 'K' of them are "locked" (cannot be repeated immediately).
                // So, there are (j - K) songs available for repetition.
                // This term is only valid if j > K (i.e., there are enough unique songs that are not "locked").
                if j > k {
                    dp[i][j] = (dp[i][j] + dp[i-1][j] * (j - k) as i64) % modulo;
                }
            }
        }

        // The final answer is the number of playlists of length L using exactly N unique songs.
        dp[l][n] as i32
    }
}