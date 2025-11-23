var shortestCommonSupersequence = function(str1, str2) {
    const m = str1.length;
    const n = str2.length;

    // dp[i][j] will store the length of the Longest Common Subsequence (LCS)
    // of str1[0...i-1] and str2[0...j-1]
    const dp = Array.from({ length: m + 1 }, () => Array(n + 1).fill(0));

    // Fill the dp table
    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            if (str1[i - 1] === str2[j - 1]) {
                dp[i][j] = 1 + dp[i - 1][j - 1];
            } else {
                dp[i][j] = Math.max(dp[i - 1][j], dp[i][j - 1]);
            }
        }
    }

    // Reconstruct the Shortest Common Supersequence (SCS)
    let i = m;
    let j = n;
    const scs = [];

    while (i > 0 && j > 0) {
        if (str1[i - 1] === str2[j - 1]) {
            // If characters match, they are part of the LCS and SCS
            scs.push(str1[i - 1]);
            i--;
            j--;
        } else if (dp[i - 1][j] < dp[i][j - 1]) {
            // If the LCS without str2[j-1] is shorter, it means str2[j-1]
            // was necessary to achieve the LCS length from dp[i][j-1].
            // So, str2[j-1] is not part of the common subsequence path from here,
            // we must include it in SCS and move left in dp table.
            scs.push(str2[j - 1]);
            j--;
        } else {
            // If the LCS without str1[i-1] is shorter or equal, it means str1[i-1]
            // was necessary to achieve the LCS length from dp[i-1][j].
            // So, str1[i-1] is not part of the common subsequence path from here,
            // we must include it in SCS and move up in dp table.
            scs.push(str1[i - 1]);
            i--;
        }
    }

    // Add remaining characters from str1 (if any)
    while (i > 0) {
        scs.push(str1[i - 1]);
        i--;
    }

    // Add remaining characters from str2 (if any)
    while (j > 0) {
        scs.push(str2[j - 1]);
        j--;
    }

    // The SCS was built in reverse, so reverse it and join to form the string
    return scs.reverse().join('');
};