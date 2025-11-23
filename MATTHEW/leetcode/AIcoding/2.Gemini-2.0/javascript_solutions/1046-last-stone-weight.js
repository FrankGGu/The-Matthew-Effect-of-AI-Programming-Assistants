var lastStoneWeight = function(stones) {
    stones.sort((a, b) => a - b);

    while (stones.length > 1) {
        let y = stones.pop();
        let x = stones.pop();

        if (x !== y) {
            stones.push(Math.abs(x - y));
            stones.sort((a, b) => a - b);
        }
    }

    return stones.length === 0 ? 0 : stones[0];
};