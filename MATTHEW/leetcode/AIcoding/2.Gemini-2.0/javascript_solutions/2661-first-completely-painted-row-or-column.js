var firstCompleteIndex = function(arr, mat) {
    const m = mat.length;
    const n = mat[0].length;
    const pos = new Map();

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            pos.set(mat[i][j], [i, j]);
        }
    }

    const rowCnt = new Array(m).fill(0);
    const colCnt = new Array(n).fill(0);

    for (let i = 0; i < arr.length; i++) {
        const [row, col] = pos.get(arr[i]);
        rowCnt[row]++;
        colCnt[col]++;

        if (rowCnt[row] === n || colCnt[col] === m) {
            return i;
        }
    }

    return -1;
};