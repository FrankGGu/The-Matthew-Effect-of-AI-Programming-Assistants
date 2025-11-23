var countPaths = function(matrix, target) {
    const m = matrix.length;
    const n = matrix[0].length;
    let count = 0;
    const prefixXor = new Map();
    prefixXor.set(0, 1);

    const dfs = (i, j, xor) => {
        if (i >= m || j >= n) {
            return;
        }

        xor ^= matrix[i][j];

        if (i === m - 1 && j === n - 1) {
            if (xor === target) {
                count++;
            }
            return;
        }

        dfs(i + 1, j, xor);
        dfs(i, j + 1, xor);
    };

    dfs(0, 0, 0);
    return count;
};