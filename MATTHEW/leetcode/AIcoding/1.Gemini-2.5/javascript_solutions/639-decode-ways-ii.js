var numDecodings = function(s) {
    const MOD = 1000000007;
    const n = s.length;

    // dp_prev_prev represents dp[i-2]
    // dp_prev represents dp[i-1]
    // dp_curr represents dp[i]

    // Base case: dp[0] = 1 (empty string has one way to decode)
    let dp_prev_prev = 1; 

    // Initialize dp[1] based on the first character s[0]
    let dp_prev;
    if (s[0] === '*') {
        dp_prev = 9;
    } else if (s[0] === '0') {
        dp_prev = 0;
    } else {
        dp_prev = 1;
    }

    for (let i = 2; i <= n; i++) {
        let dp_curr = 0;
        const c1 = s[i - 1]; // Current character
        const c2 = s[i - 2]; // Previous character

        // Calculate ways to decode s[i-1] as a single digit
        if (c1 === '*') {
            dp_curr = (dp_curr + 9 * dp_prev) % MOD;
        } else if (c1 !== '0') {
            dp_curr = (dp_curr + dp_prev) % MOD;
        }

        // Calculate ways to decode s[i-2]s[i-1] as a two-digit number
        if (c2 === '1') {
            if (c1 === '*') {
                dp_curr = (dp_curr + 9 * dp_prev_prev) % MOD; // 11-19 (9 ways)
            } else { // c1 is '0'-'9'
                dp_curr = (dp_curr + dp_prev_prev) % MOD; // 10-19 (1 way)
            }
        } else if (c2 === '2') {
            if (c1 === '*') {
                dp_curr = (dp_curr + 6 * dp_prev_prev) % MOD; // 21-26 (6 ways)
            } else if (c1 >= '0' && c1 <= '6') {
                dp_curr = (dp_curr + dp_prev_prev) % MOD; // 20-26 (1 way)
            }
        } else if (c2 === '*') {
            if (c1 === '*') {
                dp_curr = (dp_curr + 15 * dp_prev_prev) % MOD; // 1* (9 ways) + 2* (6 ways) = 15 ways
            } else if (c1 >= '0' && c1 <= '6') {
                dp_curr = (dp_curr + 2 * dp_prev_prev) % MOD; // 1(0-6) (1 way) + 2(0-6) (1 way) = 2 ways
            } else { // c1 is '7'-'9'
                dp_curr = (dp_curr + dp_prev_prev) % MOD; // 1(7-9) (1 way), 2(7-9) (0 ways) = 1 way
            }
        }

        dp_prev_prev = dp_prev;
        dp_prev = dp_curr;
    }

    return dp_prev;
};