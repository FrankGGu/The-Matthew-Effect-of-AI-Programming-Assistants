var lastStoneWeight = function(stones) {
    stones.sort((a, b) => b - a);

    while (stones.length > 1) {
        const y = stones.shift();
        const x = stones.shift();

        if (y > x) {
            stones.push(y - x);
            stones.sort((a, b) => b - a);
        }
    }

    return stones.length === 1 ? stones[0] : 0;
};