var gridGame = function(grid) {
    const n = grid[0].length;
    const prefixTop = new Array(n + 1).fill(0);
    const prefixBottom = new Array(n + 1).fill(0);

    for (let i = n - 1; i >= 0; i--) {
        prefixTop[i] = prefixTop[i + 1] + grid[0][i];
    }

    for (let i = 0; i < n; i++) {
        prefixBottom[i + 1] = prefixBottom[i] + grid[1][i];
    }

    let res = Infinity;
    for (let i = 0; i < n; i++) {
        const option1 = prefixTop[i + 1];
        const option2 = prefixBottom[i];
        res = Math.min(res, Math.max(option1, option2));
    }

    return res;
};