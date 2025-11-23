function matrixSum(n, queries) {
    let matrix = new Array(n).fill(0).map(() => new Array(n).fill(0));
    for (let [i, j] of queries) {
        matrix[i][j]++;
    }
    let sum = 0;
    for (let row of matrix) {
        sum += row.reduce((a, b) => a + b, 0);
    }
    return sum;
}