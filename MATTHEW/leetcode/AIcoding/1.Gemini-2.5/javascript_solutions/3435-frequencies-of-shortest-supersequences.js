var numShortestSupersequences = function(str1, str2) {
    const MOD = 10 ** 9 + 7;
    const n = str1.length;
    const m = str2.length;

    // dp[i][j] will store an array [length, count]
    // length: the length of the shortest common supersequence of str1[0...i-1] and str2[0...j-1]
    // count: the number of such shortest common supersequences
    const dp = Array(n + 1).fill(0).map(() => Array(m + 1).fill(0));

    // Initialize dp table with [0, 0] for all cells
    for (let i = 0; i <= n; i++) {
        for (let j = 0; j <= m; j++) {
            dp[i][j] = [0, 0];
        }
    }

    // Base cases
    // SCS of two empty strings is an empty string, length 0, count 1
    dp[0][0] = [0, 1];

    // SCS of str1[0...i-1] and an empty string is str1[0...i-1] itself
    // Length is i, count is 1 (only one way to form it)
    for (let i = 1; i <= n; i++) {
        dp[i][0] = [i, 1];
    }

    // SCS of an empty string and str2[0...j-1] is str2[0...j-1] itself
    // Length is j, count is 1 (only one way to form it)
    for (let j = 1; j <= m; j++) {
        dp[0][j] = [j, 1];
    }

    // Fill the DP table
    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= m; j++) {
            if (str1[i - 1] === str2[j - 1]) {
                // If characters match, they contribute one character to the SCS
                // The SCS is formed by appending this character to the SCS of str1[0...i-2] and str2[0...j-2]
                dp[i][j][0] = dp[i - 1][j - 1][0] + 1;
                dp[i][j][1] = dp[i - 1][j - 1][1];
            } else {
                // If characters do not match, we must include both str1[i-1] and str2[j-1] at some point.
                // We consider two options and choose the one(s) that yield the minimum length.

                // Option 1: Append str1[i-1] to SCS of str1[0...i-2] and str2[0...j-1]
                const len1 = dp[i - 1][j][0] + 1;
                const count1 = dp[i - 1][j][1];

                // Option 2: Append str2[j-1] to SCS of str1[0...i-1] and str2[0...j-2]
                const len2 = dp[i][j - 1][0] + 1;
                const count2 = dp[i][j - 1][1];

                if (len1 < len2) {
                    // Option 1 gives a shorter SCS
                    dp[i][j][0] = len1;
                    dp[i][j][1] = count1;
                } else if (len2 < len1) {
                    // Option 2 gives a shorter SCS
                    dp[i][j][0] = len2;
                    dp[i][j][1] = count2;
                } else { // len1 === len2
                    // Both options give the same shortest SCS length
                    // Sum their counts, applying modulo
                    dp[i][j][0] = len1; // or len2, they are equal
                    dp[i][j][1] = (count1 + count2) % MOD;
                }
            }
        }
    }

    // The result is the count of shortest supersequences for the full strings
    return dp[n][m][1];
};