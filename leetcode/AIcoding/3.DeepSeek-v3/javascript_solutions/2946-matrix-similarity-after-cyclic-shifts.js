var areSimilar = function(mat, k) {
    const m = mat.length;
    const n = mat[0].length;
    const original = JSON.parse(JSON.stringify(mat));

    for (let i = 0; i < m; i++) {
        const row = mat[i];
        const shift = k % n;
        if (i % 2 === 0) {
            mat[i] = row.slice(shift).concat(row.slice(0, shift));
        } else {
            mat[i] = row.slice(n - shift).concat(row.slice(0, n - shift));
        }
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (mat[i][j] !== original[i][j]) {
                return false;
            }
        }
    }

    return true;
};