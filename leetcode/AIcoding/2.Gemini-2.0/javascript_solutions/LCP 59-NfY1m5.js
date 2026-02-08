var minCostToMoveStones = function(stones) {
    stones.sort((a, b) => a - b);
    let cost = 0;
    for (let i = 1; i < stones.length; i++) {
        cost += stones[i] - stones[i - 1];
    }
    return cost;
};