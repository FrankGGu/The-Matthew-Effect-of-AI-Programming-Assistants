function maxCoins(coins, k) {
    let n = coins.length;
    let maxSum = 0;
    for (let i = 0; i <= n - k; i++) {
        let sum = 0;
        for (let j = 0; j < k; j++) {
            sum += coins[i + j];
        }
        maxSum = Math.max(maxSum, sum);
    }
    return maxSum;
}