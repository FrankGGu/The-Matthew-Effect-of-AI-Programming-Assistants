function peopleAwareOfSecret(n, delay, forget) {
    const dp = new Array(n + 1).fill(0);
    dp[1] = 1;
    for (let day = 2; day <= n; day++) {
        for (let prevDay = 1; prevDay < day; prevDay++) {
            if (day - prevDay >= delay && day - prevDay < forget) {
                dp[day] += dp[prevDay];
            }
        }
    }
    let result = 0;
    for (let i = n - forget + 1; i <= n; i++) {
        result += dp[i];
    }
    return result;
}