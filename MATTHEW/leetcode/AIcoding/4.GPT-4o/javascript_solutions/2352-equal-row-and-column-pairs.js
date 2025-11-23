var equalPairs = function(grid) {
    const countMap = new Map();
    let count = 0;

    for (const row of grid) {
        const rowStr = row.join(',');
        countMap.set(rowStr, (countMap.get(rowStr) || 0) + 1);
    }

    for (let col = 0; col < grid[0].length; col++) {
        const colStr = grid.map(row => row[col]).join(',');
        count += countMap.get(colStr) || 0;
    }

    return count;
};