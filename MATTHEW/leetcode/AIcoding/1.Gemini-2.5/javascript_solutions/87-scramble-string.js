var isScramble = function(s1, s2) {
    const n = s1.length;

    if (n !== s2.length) {
        return false;
    }

    if (s1 === s2) {
        return true;
    }

    const charCount = new Array(26).fill(0);
    for (let i = 0; i < n; i++) {
        charCount[s1.charCodeAt(i) - 'a'.charCodeAt(0)]++;
        charCount[s2.charCodeAt(i) - 'a'.charCodeAt(0)]--;
    }
    for (let i = 0; i < 26; i++) {
        if (charCount[i] !== 0) {
            return false;
        }
    }

    const dp = Array(n).fill(0).map(() =>
               Array(n).fill(0).map(() =>
               Array(n + 1).fill(false)));

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            dp[i][j][1] = (s1[i] === s2[j]);
        }
    }

    for (let len = 2; len <= n; len++) {
        for (let i = 0; i <= n - len; i++) {
            for (let j = 0; j <= n - len; j++) {
                for (let k = 1; k < len; k++) {
                    if (dp[i][j][k] && dp[i + k][j + k][len - k]) {
                        dp[i][j][len] = true;
                        break;
                    }

                    if (dp[i][j + len - k][k] && dp[i + k][j][len - k]) {
                        dp[i][j][len] = true;
                        break;
                    }
                }
            }
        }
    }

    return dp[0][0][n];
};