var minInsertions = function(s) {
    const n = s.length;

    // dp[i][j] will store the length of the Longest Palindromic Subsequence (LPS)
    // for the substring s[i...j].
    const dp = Array(n).fill(0).map(() => Array(n).fill(0));

    // Fill the DP table
    // 'len' represents the length of the current substring being considered.
    for (let len = 1; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            const j = i + len - 1;

            if (len === 1) {
                // A single character is a palindrome of length 1.
                dp[i][j] = 1;
            } else {
                if (s[i] === s[j]) {
                    // If the characters at the ends match, they contribute 2 to the LPS.
                    // We then add the LPS of the inner substring s[i+1...j-1].
                    // If i+1 > j-1, it means the inner substring is empty or has one character.
                    // For example, if len=2 (e.g., "aa"), i=0, j=1, then i+1=1, j-1=0. dp[1][0] is 0.
                    // If len=3 (e.g., "aba"), i=0, j=2, then i+1=1, j-1=1. dp[1][1] is 1.
                    dp[i][j] = 2 + (i + 1 <= j - 1 ? dp[i+1][j-1] : 0);
                } else {
                    // If the characters at the ends do not match, we must skip one of them.
                    // The LPS is the maximum of:
                    // 1. LPS of s[i+1...j] (skipping s[i])
                    // 2. LPS of s[i...j-1] (skipping s[j])
                    dp[i][j] = Math.max(dp[i+1][j], dp[i][j-1]);
                }
            }
        }
    }

    // The length of the Longest Palindromic Subsequence for the entire string s is dp[0][n-1].
    const lpsLength = dp[0][n-1];

    // The minimum number of insertions required to make a string a palindrome
    // is the total length of the string minus the length of its LPS.
    return n - lpsLength;
};