var putMarbles = function(weights, k) {
    if (weights.length === k || k === 1) {
        return 0;
    }

    const n = weights.length;
    const pairWeights = [];

    for (let i = 0; i < n - 1; i++) {
        pairWeights.push(weights[i] + weights[i + 1]);
    }

    pairWeights.sort((a, b) => a - b);

    let minSum = 0;
    let maxSum = 0;

    for (let i = 0; i < k - 1; i++) {
        minSum += pairWeights[i];
        maxSum += pairWeights[pairWeights.length - 1 - i];
    }

    return maxSum - minSum;
};