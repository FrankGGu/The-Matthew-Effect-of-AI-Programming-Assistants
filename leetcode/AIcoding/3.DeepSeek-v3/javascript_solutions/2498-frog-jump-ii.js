var maxJump = function(stones) {
    let maxCost = stones[1] - stones[0];
    for (let i = 2; i < stones.length; i++) {
        maxCost = Math.max(maxCost, stones[i] - stones[i - 2]);
    }
    return maxCost;
};