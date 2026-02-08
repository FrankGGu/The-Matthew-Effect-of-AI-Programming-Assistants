var diagonalSort = function(mat) {
    const m = mat.length, n = mat[0].length;
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

    for (const key of map.keys()) {
        const diagonal = map.get(key);
        diagonal.sort((a, b) => a - b);
        let index = 0;
        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                if (i - j === key) {
                    mat[i][j] = diagonal[index++];
                }
            }
        }
    }

    return mat;
};