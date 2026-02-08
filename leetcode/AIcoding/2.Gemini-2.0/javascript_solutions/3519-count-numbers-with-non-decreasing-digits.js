var countNumbersWithUniqueDigits = function(n) {
    if (n === 0) return 1;
    if (n > 10) n = 10;
    let dp = new Array(n + 1).fill(0);
    dp[0] = 1;
    dp[1] = 10;
    let uniqueDigits = 9;
    let availableNumber = 9;
    for (let i = 2; i <= n; i++) {
        uniqueDigits = uniqueDigits * availableNumber;
        dp[i] = dp[i - 1] + uniqueDigits;
        availableNumber--;
    }
    return dp[n];
};