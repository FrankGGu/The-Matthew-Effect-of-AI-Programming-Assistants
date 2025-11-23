var stoneGameII = function(piles) {
    const n = piles.length;
    const memo = new Map();

    function dfs(index, M) {
        if (index >= n) return 0;
        const key = `${index},${M}`;
        if (memo.has(key)) return memo.get(key);

        let max = -Infinity;
        let sum = 0;
        for (let x = 1; x <= 2 * M; x++) {
            if (index + x > n) break;
            sum += piles[index + x - 1];
            max = Math.max(max, sum - dfs(index + x, Math.max(M, x)));
        }

        memo.set(key, max);
        return max;
    }

    const total = piles.reduce((a, b) => a + b, 0);
    const diff = dfs(0, 1);
    return (total + diff) / 2;
};