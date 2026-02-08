var areSimilar = function(mat, k) {
    const m = mat.length;
    const n = mat[0].length;

    const effectiveK = k % n;

    if (effectiveK === 0) {
        return true;
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (i % 2 === 0) { 
                if (mat[i][j] !== mat[i][(j - effectiveK + n) % n]) {
                    return false;
                }
            } else {
                if (mat[i][j] !== mat[i][(j + effectiveK) % n]) {
                    return false;
                }
            }
        }
    }

    return true;
};