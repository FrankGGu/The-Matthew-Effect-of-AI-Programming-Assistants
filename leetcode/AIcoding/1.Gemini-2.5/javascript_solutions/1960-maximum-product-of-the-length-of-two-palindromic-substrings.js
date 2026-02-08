var maxProduct = function(s) {
    const n = s.length;

    if (n < 2) {
        return 0;
    }

    const dp = Array(n).fill(0).map(() => Array(n).fill(false));

    for (let i = 0; i < n; i++) {
        dp[i][i] = true;
    }

    for (let i = 0; i < n - 1; i++) {
        if (s[i] === s[i + 1]) {
            dp[i][i + 1] = true;
        }
    }

    for (let len = 3; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            const j = i + len - 1;
            if (s[i] === s[j] && dp[i + 1][j - 1]) {
                dp[i][j] = true;
            }
        }
    }

    const maxLenLeft = Array(n).fill(0);
    const maxLenRight = Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        if (i > 0) {
            maxLenLeft[i] = maxLenLeft[i - 1];
        }
        for (let j = 0; j <= i; j++) {
            if (dp[j][i]) {
                maxLenLeft[i] = Math.max(maxLenLeft[i], i - j + 1);
            }
        }
    }

    for (let i = n - 1; i >= 0; i--) {
        if (i < n - 1) {
            maxLenRight[i] = maxLenRight[i + 1];
        }
        for (let j = i; j < n; j++) {
            if (dp[i][j]) {
                maxLenRight[i] = Math.max(maxLenRight[i], j - i + 1);
            }
        }
    }

    let maxProductResult = 0;

    for (let i = 0; i < n - 1; i++) {
        maxProductResult = Math.max(maxProductResult, maxLenLeft[i] * maxLenRight[i + 1]);
    }

    return maxProductResult;
};