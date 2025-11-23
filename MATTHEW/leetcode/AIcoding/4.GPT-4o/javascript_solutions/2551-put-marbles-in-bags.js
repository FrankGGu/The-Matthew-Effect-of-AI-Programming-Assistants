var putMarbles = function(weights, k) {
    if (k === 1) return 0;

    const sortedWeights = weights.map((w, i) => w + (i < weights.length - 1 ? weights[i + 1] : 0)).sort((a, b) => a - b);
    return sortedWeights[sortedWeights.length - k + 1] - sortedWeights[k - 1];
};