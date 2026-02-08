var firstCompleteIndex = function(arr, mat) {
    const m = mat.length;
    const n = mat[0].length;
    const rowCount = new Array(m).fill(0);
    const colCount = new Array(n).fill(0);
    const posMap = new Map();

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            posMap.set(mat[i][j], [i, j]);
        }
    }

    for (let k = 0; k < arr.length; k++) {
        const num = arr[k];
        const [i, j] = posMap.get(num);
        rowCount[i]++;
        colCount[j]++;

        if (rowCount[i] === n || colCount[j] === m) {
            return k;
        }
    }

    return -1;
};