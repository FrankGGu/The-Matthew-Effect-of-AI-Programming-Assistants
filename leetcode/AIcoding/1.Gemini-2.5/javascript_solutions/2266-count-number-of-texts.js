var countTexts = function(pressedKeys) {
    const MOD = 10**9 + 7;
    const n = pressedKeys.length;

    // dp[i] will store the number of ways to decode the prefix of length i
    const dp = new Array(n + 1).fill(0);
    dp[0] = 1; // Base case: one way to decode an empty string

    for (let i = 1; i <= n; i++) {
        // Option 1: Decode pressedKeys[i-1] as a single character
        // This contributes dp[i-1] ways.
        dp[i] = dp[i-1];

        // Option 2: Decode pressedKeys[i-2]pressedKeys[i-1] as two characters
        // This is possible if i >= 2 and the two characters are the same.
        if (i >= 2 && pressedKeys[i-1] === pressedKeys[i-2]) {
            dp[i] = (dp[i] + dp[i-2]) % MOD;

            // Option 3: Decode pressedKeys[i-3]pressedKeys[i-2]pressedKeys[i-1] as three characters
            // This is possible if i >= 3 and all three characters are the same.
            // (pressedKeys[i-1] === pressedKeys[i-2] is already checked)
            if (i >= 3 && pressedKeys[i-1] === pressedKeys[i-3]) {
                dp[i] = (dp[i] + dp[i-3]) % MOD;

                // Option 4: Decode pressedKeys[i-4]...pressedKeys[i-1] as four characters
                // This is possible if i >= 4, all four characters are the same,
                // AND the digit is '7' or '9'.
                // (pressedKeys[i-1] === pressedKeys[i-2] === pressedKeys[i-3] is already checked)
                if (i >= 4 && (pressedKeys[i-1] === '7' || pressedKeys[i-1] === '9') && pressedKeys[i-1] === pressedKeys[i-4]) {
                    dp[i] = (dp[i] + dp[i-4]) % MOD;
                }
            }
        }
    }

    return dp[n];
};