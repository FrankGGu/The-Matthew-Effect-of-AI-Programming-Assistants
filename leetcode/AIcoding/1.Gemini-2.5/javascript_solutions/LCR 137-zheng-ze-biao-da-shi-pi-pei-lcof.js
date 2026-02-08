var isMatch = function(s, p) {
    const m = s.length;
    const n = p.length;

    let dp = new Array(n + 1).fill(false);

    dp[0] = true;

    for (let j = 1; j <= n; j++) {
        if (p[j - 1] === '*') {
            dp[j] = dp[j - 1];
        } else {
            dp[j] = false;
        }
    }

    for (let i = 1; i <= m; i++) {
        let prev_top_left = dp[0]; 
        dp[0] = false; 

        for (let j = 1; j <= n; j++) {
            let temp = dp[j]; 

            if (p[j - 1] === s[i - 1] || p[j - 1] === '?') {
                dp[j] = prev_top_left;
            } else if (p[j - 1] === '*') {
                dp[j] = dp[j - 1] || temp;
            } else {
                dp[j] = false;
            }
            prev_top_left = temp; 
        }
    }

    return dp[n];
};