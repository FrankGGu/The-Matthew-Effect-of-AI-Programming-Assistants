var numMovesStonesII = function(stones) {
    stones.sort((a, b) => a - b);
    const n = stones.length;
    let max = stones[n - 1] - stones[0] + 1 - n - Math.min(stones[n - 1] - stones[n - 2] - 1, stones[1] - stones[0] - 1);
    let min = max;
    let i = 0;
    for (let j = 0; j < n; j++) {
        while (stones[j] - stones[i] + 1 > n) {
            i++;
        }
        if (stones[j] - stones[i] + 1 === n - 1 && j - i + 1 === n - 1) {
            min = Math.min(min, 2);
        } else {
            min = Math.min(min, n - (j - i + 1));
        }
    }
    return [min, max];
};