var frogJumpII = function(stones) {
    const n = stones.length;

    if (n <= 1) {
        return 0;
    }

    let maxGap = 0;
    for (let i = 0; i < n - 1; i++) {
        maxGap = Math.max(maxGap, stones[i + 1] - stones[i]);
    }

    return maxGap;
};