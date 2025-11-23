var numMovesStonesII = function(stones) {
    stones.sort((a, b) => a - b);
    const n = stones.length;
    let minMoves = Math.min(stones[n - 1] - stones[1] - (n - 2), stones[n - 2] - stones[0] - (n - 2)) + 1;

    let j = 0;
    for (let i = 0; i < n; i++) {
        while (j < n && stones[j] - stones[i] < n) j++;
        let count = j - i;
        if (count === n - 1) minMoves = Math.min(minMoves, 2);
        if (count === n) minMoves = Math.min(minMoves, 0);
    }

    return [minMoves, Math.max(0, stones[n - 1] - stones[0] - n + 2)];
};