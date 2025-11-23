var topKSales = function(sales, k) {
    const n = sales.length;
    if (n < k) {
        return [];
    }

    const result = [];
    let currentSum = 0;

    for (let i = 0; i < k; i++) {
        currentSum += sales[i];
    }

    result.push(currentSum);

    for (let i = k; i < n; i++) {
        currentSum = currentSum - sales[i - k] + sales[i];
        result.push(currentSum);
    }

    return result;
};