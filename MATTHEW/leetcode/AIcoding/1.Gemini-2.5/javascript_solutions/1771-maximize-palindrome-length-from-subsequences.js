var longestPalindrome = function(word1, word2) {
    const n1 = word1.length;
    const n2 = word2.length;
    const S = word1 + word2;
    const N = S.length;

    const dp = Array(N).fill(0).map(() => Array(N).fill(0));

    for (let i = 0; i < N; i++) {
        dp[i][i] = 1;
    }

    for (let len = 2; len <= N; len++) {
        for (let i = 0; i <= N - len; i++) {
            const j = i + len - 1;
            if (S[i] === S[j]) {
                dp[i][j] = (len === 2) ? 2 : dp[i + 1][j - 1] + 2;
            } else {
                dp[i][j] = Math.max(dp[i + 1][j], dp[i][j - 1]);
            }
        }
    }

    let max_len = 0;

    // Initialize max_len with the LPS of word1 and word2 individually.
    // Problem constraints guarantee n1, n2 >= 1.
    max_len = Math.max(dp[0][n1 - 1], dp[n1][N - 1]);

    // Iterate through all possible pairs (word1[i], word2[j]) that can form
    // the outermost matching characters of a palindrome P = sub1 + sub2.
    // Here, sub1 is a subsequence of word1 and sub2 is a subsequence of word2.
    // The structure implies that all characters from sub1 appear before all characters from sub2 in P.
    // If word1[i] and word2[j] are the outermost characters, they must be equal.
    // The inner palindrome would then be formed from the subsequence of S[i+1 ... n1+j-1].
    for (let i = 0; i < n1; i++) {
        for (let j = 0; j < n2; j++) {
            if (word1[i] === word2[j]) {
                let current_len = 2; // For the matching pair word1[i] and word2[j]

                // The inner part of the palindrome is formed from the segment S[i+1 ... n1+j-1].
                // 'i+1' is the index in S after word1[i].
                // 'n1+j-1' is the index in S before word2[j] (word2 starts at index n1 in S).
                const inner_start_S_idx = i + 1;
                const inner_end_S_idx = n1 + j - 1;

                // If there's a valid inner segment, add its LPS length.
                if (inner_start_S_idx <= inner_end_S_idx) {
                    current_len += dp[inner_start_S_idx][inner_end_S_idx];
                }
                max_len = Math.max(max_len, current_len);
            }
        }
    }

    return max_len;
};