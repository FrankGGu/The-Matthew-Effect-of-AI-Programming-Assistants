var stoneGameVIII = function(stones) {
    const n = stones.length;
    for (let i = 1; i < n; i++) {
        stones[i] += stones[i - 1];
    }
    let maxScore = stones[n - 1];
    let result = maxScore;
    for (let i = n - 2; i >= 1; i--) {
        result = Math.max(result, maxScore - stones[i]);
        maxScore = Math.max(maxScore, stones[i]);
    }
    return result;
};