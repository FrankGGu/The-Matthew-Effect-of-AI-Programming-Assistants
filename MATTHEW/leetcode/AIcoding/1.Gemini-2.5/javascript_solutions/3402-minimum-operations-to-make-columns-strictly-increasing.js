var minimumOperations = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    let totalOperations = 0;

    for (let j = 0; j < n; j++) {
        const currentColumn = [];
        for (let i = 0; i < m; i++) {
            currentColumn.push(grid[i][j]);
        }

        const sortedColumn = [...currentColumn].sort((a, b) => a - b);

        for (let i = 0; i < m - 1; i++) {
            if (sortedColumn[i] === sortedColumn[i+1]) {
                return -1;
            }
        }

        let minRotationsForColumn = Infinity;

        for (let offset = 0; offset < m; offset++) {
            let isMatch = true;
            for (let i = 0; i < m; i++) {
                if (currentColumn[(i + offset) % m] !== sortedColumn[i]) {
                    isMatch = false;
                    break;
                }
            }
            if (isMatch) {
                minRotationsForColumn = offset;
                break;
            }
        }

        if (minRotationsForColumn === Infinity) {
            return -1;
        }

        totalOperations += minRotationsForColumn;
    }

    return totalOperations;
};