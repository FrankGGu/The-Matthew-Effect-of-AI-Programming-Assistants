function oddCells(n, m, indices) {
    let matrix = new Array(n).fill(0).map(() => new Array(m).fill(0));
    for (let i = 0; i < indices.length; i++) {
        let row = indices[i][0];
        let col = indices[i][1];
        for (let j = 0; j < m; j++) {
            matrix[row][j]++;
        }
        for (let k = 0; k < n; k++) {
            matrix[k][col]++;
        }
    }
    let count = 0;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            if (matrix[i][j] % 2 !== 0) {
                count++;
            }
        }
    }
    return count;
}