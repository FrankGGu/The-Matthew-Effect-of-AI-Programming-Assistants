var beautifulPartitions = function(s) {
    const n = s.length;
    const isBeautiful = (str) => {
        if (str.length === 0) return false;
        if (str[0] === '0') return false;
        let num = parseInt(str);
        while (num > 0) {
            if (num % 5 !== 0) return false;
            num /= 5;
        }
        return true;
    }

    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= i; j++) {
            const sub = s.substring(i - j, i);
            if (isBeautiful(sub) && dp[i - j] !== Infinity) {
                dp[i] = Math.min(dp[i], dp[i - j] + 1);
            }
        }
    }

    return dp[n] === Infinity ? -1 : dp[n];
};