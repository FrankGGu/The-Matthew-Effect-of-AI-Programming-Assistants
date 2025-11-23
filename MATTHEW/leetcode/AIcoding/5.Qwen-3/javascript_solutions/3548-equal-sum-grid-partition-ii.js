function isPossible(grid) {
    const m = grid.length;
    const n = grid[0].length;

    function getSum(row, col) {
        let sum = 0;
        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                if (i === row || j === col) {
                    sum += grid[i][j];
                }
            }
        }
        return sum;
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const rowSum = getSum(i, -1);
            const colSum = getSum(-1, j);
            if (rowSum === colSum) {
                return true;
            }
        }
    }

    return false;
}