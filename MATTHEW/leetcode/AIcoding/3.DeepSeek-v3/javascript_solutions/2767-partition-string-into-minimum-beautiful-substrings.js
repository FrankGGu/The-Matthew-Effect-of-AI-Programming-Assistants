var minimumBeautifulSubstrings = function(s) {
    const n = s.length;
    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;
    const powerOfFive = new Set();
    let num = 1;
    powerOfFive.add(num.toString(2));
    for (let i = 1; i <= 20; i++) {
        num *= 5;
        powerOfFive.add(num.toString(2));
    }

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j < i; j++) {
            const substr = s.substring(j, i);
            if (powerOfFive.has(substr) && s[j] !== '0') {
                dp[i] = Math.min(dp[i], dp[j] + 1);
            }
        }
    }

    return dp[n] === Infinity ? -1 : dp[n];
};