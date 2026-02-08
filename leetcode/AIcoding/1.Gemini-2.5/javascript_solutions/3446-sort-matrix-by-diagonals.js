var diagonalSort = function(mat) {
    const m = mat.length;
    const n = mat[0].length;

    // Sort diagonals starting from the first row (j = 0 to n-1)
    for (let j = 0; j < n; j++) {
        let r = 0;
        let c = j;
        const diagonal = [];
        while (r < m && c < n) {
            diagonal.push(mat[r][c]);
            r++;
            c++;
        }
        diagonal.sort((a, b) => a - b);

        r = 0;
        c = j;
        let k = 0;
        while (r < m && c < n) {
            mat[r][c] = diagonal[k];
            r++;
            c++;
            k++;
        }
    }

    // Sort diagonals starting from the first column (i = 1 to m-1, as (0,0) is covered above)
    for (let i = 1; i < m; i++) {
        let r = i;
        let c = 0;
        const diagonal = [];
        while (r < m && c < n) {
            diagonal.push(mat[r][c]);
            r++;
            c++;
        }
        diagonal.sort((a, b) => a - b);

        r = i;
        c = 0;
        let k = 0;
        while (r < m && c < n) {
            mat[r][c] = diagonal[k];
            r++;
            c++;
            k++;
        }
    }

    return mat;
};