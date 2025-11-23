var diagonalSort = function(mat) {
    const m = mat.length;
    const n = mat[0].length;

    for (let j = 0; j < n; j++) {
        const diagElements = [];
        let r = 0;
        let c = j;
        while (r < m && c < n) {
            diagElements.push(mat[r][c]);
            r++;
            c++;
        }
        diagElements.sort((a, b) => a - b);

        r = 0;
        c = j;
        let idx = 0;
        while (r < m && c < n) {
            mat[r][c] = diagElements[idx];
            r++;
            c++;
            idx++;
        }
    }

    for (let i = 1; i < m; i++) {
        const diagElements = [];
        let r = i;
        let c = 0;
        while (r < m && c < n) {
            diagElements.push(mat[r][c]);
            r++;
            c++;
        }
        diagElements.sort((a, b) => a - b);

        r = i;
        c = 0;
        let idx = 0;
        while (r < m && c < n) {
            mat[r][c] = diagElements[idx];
            r++;
            c++;
            idx++;
        }
    }

    return mat;
};