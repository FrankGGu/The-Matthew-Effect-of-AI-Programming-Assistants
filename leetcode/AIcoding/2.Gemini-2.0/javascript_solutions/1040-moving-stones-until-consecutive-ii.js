var numMovesStonesII = function(stones) {
    stones.sort((a, b) => a - b);
    const n = stones.length;
    let maxMoves = Math.max(stones[n - 1] - stones[1] - n + 2, stones[n - 2] - stones[0] - n + 2);

    let minMoves = Infinity;
    let j = 0;
    for (let i = 0; i < n; i++) {
        while (stones[j] - stones[i] + 1 <= n) {
            j++;
            if (j === n) break;
        }
        let count = j - i;
        if (count === n - 1 && stones[j - 1] - stones[i] + 1 === n - 1) {
            minMoves = Math.min(minMoves, 2);
        } else {
            minMoves = Math.min(minMoves, n - count);
        }
    }

    return [minMoves, maxMoves];
};