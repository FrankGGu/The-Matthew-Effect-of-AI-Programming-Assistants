var minCut = function(s) {
    const n = s.length;

    const isPalindrome = Array(n).fill(0).map(() => Array(n).fill(false));

    for (let i = 0; i < n; i++) {
        isPalindrome[i][i] = true;
    }

    for (let i = 0; i < n - 1; i++) {
        if (s[i] === s[i+1]) {
            isPalindrome[i][i+1] = true;
        }
    }

    for (let l = 3; l <= n; l++) {
        for (let i = 0; i <= n - l; i++) {
            const j = i + l - 1;
            if (s[i] === s[j] && isPalindrome[i+1][j-1]) {
                isPalindrome[i][j] = true;
            }
        }
    }

    const dp = Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        dp[i] = i - 1; 

        for (let j = 0; j < i; j++) {
            if (isPalindrome[j][i-1]) {
                if (j === 0) {
                    dp[i] = 0;
                    break;
                } else {
                    dp[i] = Math.min(dp[i], dp[j] + 1);
                }
            }
        }
    }

    return dp[n];
};