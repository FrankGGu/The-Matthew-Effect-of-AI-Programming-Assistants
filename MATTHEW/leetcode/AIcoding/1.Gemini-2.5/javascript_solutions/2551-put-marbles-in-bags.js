var putMarbles = function(weights, k) {
    const n = weights.length;

    if (k === 1 || k === n) {
        return 0;
    }

    const pairCosts = new Array(n - 1);
    for (let i = 0; i < n - 1; i++) {
        pairCosts[i] = weights[i] + weights[i + 1];
    }

    pairCosts.sort((a, b) => a - b);

    let minSum = 0;
    let maxSum = 0;

    for (let i = 0; i < k - 1; i++) {
        minSum += pairCosts[i];
        maxSum += pairCosts[n - 2 - i];
    }

    return maxSum - minSum;
};