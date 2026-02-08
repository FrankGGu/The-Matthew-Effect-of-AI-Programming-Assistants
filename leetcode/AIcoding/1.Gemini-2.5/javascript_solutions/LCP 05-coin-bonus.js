var coinBonus = function(coins, k) {
    let n = coins.length;
    let currentSum = 0;

    for (let i = 0; i < k; i++) {
        currentSum += coins[i];
    }

    let maxBonus = currentSum;

    for (let i = 0; i < k; i++) {
        currentSum -= coins[k - 1 - i];
        currentSum += coins[n - 1 - i];
        maxBonus = Math.max(maxBonus, currentSum);
    }

    return maxBonus;
};