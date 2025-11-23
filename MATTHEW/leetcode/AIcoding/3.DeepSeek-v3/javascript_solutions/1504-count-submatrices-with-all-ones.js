var numSubmat = function(mat) {
    const m = mat.length;
    const n = mat[0].length;
    let res = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (mat[i][j] === 0) continue;

            let min = Infinity;
            for (let k = i; k >= 0; k--) {
                for (let l = j; l >= 0; l--) {
                    if (mat[k][l] === 0) break;
                    min = Math.min(min, j - l + 1);
                    res += min;
                }
            }
        }
    }

    return res;
};