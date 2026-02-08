var diagonalSort = function(mat) {
    const m = mat.length;
    const n = mat[0].length;
    const map = new Map();

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const key = i - j;
            if (!map.has(key)) {
                map.set(key, []);
            }
            map.get(key).push(mat[i][j]);
        }
    }

    for (const [key, arr] of map) {
        arr.sort((a, b) => a - b);
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const key = i - j;
            mat[i][j] = map.get(key).shift();
        }
    }

    return mat;
};