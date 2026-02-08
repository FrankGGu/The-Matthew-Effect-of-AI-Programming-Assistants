var equalSumGrid = function(grid) {
    const n = grid.length;
    let totalSum = 0;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            totalSum += grid[i][j];
        }
    }

    let rowPrefixSum = new Array(n).fill(0);
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            rowPrefixSum[i] += grid[i][j];
        }
    }

    let colPrefixSum = new Array(n).fill(0);
    for (let j = 0; j < n; j++) {
        for (let i = 0; i < n; i++) {
            colPrefixSum[j] += grid[i][j];
        }
    }

    for (let i = 0; i < n - 1; i++) {
        let sum1 = 0;
        for (let row = 0; row <= i; row++) {
            sum1 += rowPrefixSum[row];
        }
        if (sum1 * 2 === totalSum) return i;
    }

    for (let j = 0; j < n - 1; j++) {
        let sum1 = 0;
        for (let col = 0; col <= j; col++) {
            sum1 += colPrefixSum[col];
        }
        if (sum1 * 2 === totalSum) return j + n;
    }

    return -1;
};