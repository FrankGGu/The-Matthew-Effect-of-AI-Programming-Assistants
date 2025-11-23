var gridGame = function(grid) {
    const n = grid[0].length;
    const prefixSum = new Array(2).fill(0).map(() => new Array(n).fill(0));

    prefixSum[0][0] = grid[0][0];
    prefixSum[1][0] = grid[1][0];

    for(let i = 1; i < n; i++) {
        prefixSum[0][i] = prefixSum[0][i - 1] + grid[0][i];
        prefixSum[1][i] = prefixSum[1][i - 1] + grid[1][i];
    }

    let minScore = Infinity;

    for(let i = 0; i < n; i++) {
        const score = Math.max(prefixSum[1][n - 1] - (i > 0 ? prefixSum[1][i - 1] : 0), 
                               prefixSum[0][i]);
        minScore = Math.min(minScore, score);
    }

    return minScore;
};