var countSpecialSubsequences = function(s) {
    let dp0 = 0; // Number of subsequences ending with '0'
    let dp1 = 0; // Number of subsequences ending with '01'
    let dp2 = 0; // Number of subsequences ending with '012'
    const MOD = 10**9 + 7;

    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        if (char === '0') {
            // New '0' can start a new subsequence or extend existing '0'-ending subsequences.
            // (dp0 + 1) for new '0's, plus dp0 for extending existing '0'-ending subsequences.
            // Effectively, each existing dp0 subsequence can either include or not include the current '0',
            // plus the new '0' by itself. So, 2 * dp0 + 1.
            dp0 = (2 * dp0 + 1) % MOD;
        } else if (char === '1') {
            // New '1' can extend existing '0'-ending subsequences (dp0 ways)
            // or extend existing '01'-ending subsequences (dp1 ways).
            // Effectively, 2 * dp1 + dp0.
            dp1 = (2 * dp1 + dp0) % MOD;
        } else { // char === '2'
            // New '2' can extend existing '01'-ending subsequences (dp1 ways)
            // or extend existing '012'-ending subsequences (dp2 ways).
            // Effectively, 2 * dp2 + dp1.
            dp2 = (2 * dp2 + dp1) % MOD;
        }
    }

    return dp2;
};