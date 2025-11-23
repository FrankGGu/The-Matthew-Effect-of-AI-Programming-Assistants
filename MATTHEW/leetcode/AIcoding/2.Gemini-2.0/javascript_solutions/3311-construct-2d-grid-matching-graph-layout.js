var construct2DArray = function(n, m) {
    const result = [];
    for (let i = 0; i < n; i++) {
        result.push(Array(m).fill(0));
    }

    let edgeCount = 0;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            if (i < n - 1) {
                result[i][j] = edgeCount++;
                result[i+1][j] = edgeCount++;
            }
            if (j < m - 1) {
                result[i][j] = edgeCount++;
                result[i][j+1] = edgeCount++;
            }
        }
    }
    return result;
};