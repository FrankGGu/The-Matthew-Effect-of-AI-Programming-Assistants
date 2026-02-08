function numMovesStonesII(stones) {
    stones.sort((a, b) => a - b);
    const n = stones.length;
    if (stones[1] - stones[0] === 1 && stones[n - 1] - stones[n - 2] === 1) {
        return 0;
    }
    let min = Infinity;
    for (let i = 0; i < n; i++) {
        let j = i;
        while (j + 1 < n && stones[j + 1] - stones[j] === 1) {
            j++;
        }
        if (j - i + 1 === n) {
            return 0;
        }
        if (j - i + 1 === n - 1) {
            min = Math.min(min, 1);
        } else {
            min = Math.min(min, n - (j - i + 1));
        }
    }
    return min;
}