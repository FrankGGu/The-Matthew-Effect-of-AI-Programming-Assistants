var equalPairs = function(grid) {
    const n = grid.length;
    const rowMap = new Map();
    const colMap = new Map();

    for (let i = 0; i < n; i++) {
        const rowKey = grid[i].join(',');
        rowMap.set(rowKey, (rowMap.get(rowKey) || 0) + 1);
    }

    for (let j = 0; j < n; j++) {
        const col = [];
        for (let i = 0; i < n; i++) {
            col.push(grid[i][j]);
        }
        const colKey = col.join(',');
        colMap.set(colKey, (colMap.get(colKey) || 0) + 1);
    }

    let count = 0;
    for (const [key, value] of rowMap) {
        if (colMap.has(key)) {
            count += value * colMap.get(key);
        }
    }

    return count;
};