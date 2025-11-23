var diagonalSort = function(mat) {
    const m = mat.length;
    const n = mat[0].length;
    const map = new Map();

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const diff = i - j;
            if (!map.has(diff)) {
                map.set(diff, []);
            }
            map.get(diff).push(mat[i][j]);
        }
    }

    for (const key of map.keys()) {
        map.get(key).sort((a, b) => a - b);
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const diff = i - j;
            mat[i][j] = map.get(diff).shift();
        }
    }

    return mat;
};