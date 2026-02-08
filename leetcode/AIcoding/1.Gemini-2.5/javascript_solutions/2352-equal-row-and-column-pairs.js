var equalPairs = function(grid) {
    const n = grid.length;
    const rowFrequencies = new Map();

    for (let i = 0; i < n; i++) {
        const rowString = grid[i].join(',');
        rowFrequencies.set(rowString, (rowFrequencies.get(rowString) || 0) + 1);
    }

    let count = 0;
    for (let j = 0; j < n; j++) {
        const currentColumn = [];
        for (let i = 0; i < n; i++) {
            currentColumn.push(grid[i][j]);
        }
        const colString = currentColumn.join(',');
        if (rowFrequencies.has(colString)) {
            count += rowFrequencies.get(colString);
        }
    }

    return count;
};