function minimumBeautifulSubstrings(s) {
    const isBeautiful = (num) => {
        while (num > 0) {
            if (num % 10 !== 0 && num % 10 !== 1) return false;
            num = Math.floor(num / 10);
        }
        return true;
    };

    const n = s.length;
    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; i++) {
        let num = 0;
        for (let j = i; j >= 1; j--) {
            num = (num << 1) + (s[j - 1] - '0');
            if (isBeautiful(num)) {
                dp[i] = Math.min(dp[i], dp[j - 1] + 1);
            }
        }
    }

    return dp[n] === Infinity ? -1 : dp[n];
}