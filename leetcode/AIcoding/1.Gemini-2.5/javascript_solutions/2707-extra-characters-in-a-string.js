var minExtraChar = function(s, dictionary) {
    const n = s.length;
    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    const dictSet = new Set(dictionary);

    for (let i = 1; i <= n; i++) {
        // Option 1: The character s[i-1] is an extra character
        dp[i] = dp[i-1] + 1;

        // Option 2: The substring s[j...i-1] is a word in the dictionary
        // We iterate through all possible starting points j for a word ending at i-1
        for (let j = 0; j < i; j++) {
            const sub = s.substring(j, i);
            if (dictSet.has(sub)) {
                dp[i] = Math.min(dp[i], dp[j]);
            }
        }
    }

    return dp[n];
};