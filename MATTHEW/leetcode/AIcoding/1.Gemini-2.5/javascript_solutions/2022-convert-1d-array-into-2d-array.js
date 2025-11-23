var construct2DArray = function(original, m, n) {
    if (original.length !== m * n) {
        return [];
    }

    const result = [];
    let originalIndex = 0;

    for (let i = 0; i < m; i++) {
        const row = [];
        for (let j = 0; j < n; j++) {
            row.push(original[originalIndex]);
            originalIndex++;
        }
        result.push(row);
    }

    return result;
};