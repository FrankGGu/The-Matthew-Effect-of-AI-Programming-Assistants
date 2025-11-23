var getLengthOfOptimalCompression = function(s, k) {
    const n = s.length;
    const dp = Array(n + 1).fill(null).map(() => Array(k + 1).fill(Infinity));
    dp[0][0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j <= k; j++) {
            if (j > 0) {
                dp[i][j] = Math.min(dp[i][j], dp[i - 1][j - 1]);
            }

            let count = 0;
            let deleted = 0;
            for (let l = i; l >= 1; l--) {
                if (s[l - 1] === s[i - 1]) {
                    count++;
                } else {
                    deleted++;
                }

                if (deleted > j) {
                    break;
                }

                let len = 0;
                if (count === 1) {
                    len = 1;
                } else if (count < 10) {
                    len = 2;
                } else if (count < 100) {
                    len = 3;
                } else {
                    len = 4;
                }
                if(count > 1) len--;

                dp[i][j] = Math.min(dp[i][j], dp[l - 1][j - deleted] + len);
            }
        }
    }

    return dp[n][k];
};