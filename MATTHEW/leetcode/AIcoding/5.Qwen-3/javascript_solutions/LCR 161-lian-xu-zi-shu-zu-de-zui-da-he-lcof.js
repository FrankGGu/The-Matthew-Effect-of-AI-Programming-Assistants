function maxContinuousSales(sales) {
    if (sales.length === 0) return 0;

    let maxSum = sales[0];
    let currentSum = sales[0];

    for (let i = 1; i < sales.length; i++) {
        currentSum = Math.max(sales[i], currentSum + sales[i]);
        maxSum = Math.max(maxSum, currentSum);
    }

    return maxSum;
}