var construct2DArray = function(original, m, n) {
    if (original.length !== m * n) {
        return [];
    }
    const result = [];
    for (let i = 0; i < m; i++) {
        const row = original.slice(i * n, (i + 1) * n);
        result.push(row);
    }
    return result;
};