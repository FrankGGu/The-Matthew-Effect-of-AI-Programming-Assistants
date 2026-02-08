var putMarbles = function(weights, k) {
    const n = weights.length;
    const pairs = [];
    for (let i = 0; i < n - 1; i++) {
        pairs.push(weights[i] + weights[i + 1]);
    }
    pairs.sort((a, b) => a - b);
    let minSum = 0;
    let maxSum = 0;
    for (let i = 0; i < k - 1; i++) {
        minSum += pairs[i];
        maxSum += pairs[n - 2 - i];
    }
    return maxSum - minSum;
};