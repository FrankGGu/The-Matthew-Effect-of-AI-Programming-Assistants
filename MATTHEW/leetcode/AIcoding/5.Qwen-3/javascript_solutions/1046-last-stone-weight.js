function lastStoneWeight(stones) {
    while (stones.length > 1) {
        stones.sort((a, b) => b - a);
        const x = stones[0];
        const y = stones[1];
        if (x === y) {
            stones.splice(0, 2);
        } else {
            stones[0] = x - y;
            stones.splice(1, 1);
        }
    }
    return stones[0] || 0;
}