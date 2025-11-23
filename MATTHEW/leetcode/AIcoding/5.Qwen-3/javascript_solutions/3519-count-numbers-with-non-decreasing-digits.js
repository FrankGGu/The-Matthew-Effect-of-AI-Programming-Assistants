function countNumbersWithNonDecreasingDigits(n) {
    const s = n.toString();
    const dp = Array.from({ length: 11 }, () => Array(s.length).fill(0));

    for (let i = 1; i <= 9; i++) {
        dp[i][0] = 1;
    }

    for (let i = 1; i <= 9; i++) {
        for (let j = 1; j < s.length; j++) {
            for (let k = 0; k <= i; k++) {
                dp[i][j] += dp[k][j - 1];
            }
        }
    }

    let res = 0;
    for (let i = 1; i <= 9; i++) {
        res += dp[i][s.length - 1];
    }

    for (let i = 0; i < s.length; i++) {
        for (let j = 0; j < parseInt(s[i]); j++) {
            res += dp[j][i];
        }
        if (i > 0 && s[i] < s[i - 1]) break;
    }

    return res;
}