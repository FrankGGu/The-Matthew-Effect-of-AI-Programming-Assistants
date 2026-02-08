var firstCompleteIndex = function(mat, arr) {
    const m = mat.length;
    const n = mat[0].length;

    const numToPos = new Map();
    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            numToPos.set(mat[r][c], [r, c]);
        }
    }

    const rowCount = new Array(m).fill(0);
    const colCount = new Array(n).fill(0);

    for (let k = 0; k < arr.length; k++) {
        const num = arr[k];
        const [r, c] = numToPos.get(num);

        rowCount[r]++;
        colCount[c]++;

        if (rowCount[r] === n || colCount[c] === m) {
            return k;
        }
    }

    return -1; 
};