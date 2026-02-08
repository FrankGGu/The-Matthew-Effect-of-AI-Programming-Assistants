var maximumRows = function(matrix, cols) {
    const m = matrix.length;
    const n = matrix[0].length;
    let maxRows = 0;

    for (let i = 0; i < (1 << n); i++) {
        if (countSetBits(i) !== cols) {
            continue;
        }

        let selectedCols = [];
        for (let j = 0; j < n; j++) {
            if ((i >> j) & 1) {
                selectedCols.push(j);
            }
        }

        let coveredRows = 0;
        for (let row = 0; row < m; row++) {
            let isCovered = true;
            for (let col = 0; col < n; col++) {
                if (matrix[row][col] === 1) {
                    let found = false;
                    for (let selectedCol of selectedCols) {
                        if (col === selectedCol) {
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        isCovered = false;
                        break;
                    }
                }
            }
            if (isCovered) {
                coveredRows++;
            }
        }
        maxRows = Math.max(maxRows, coveredRows);
    }

    return maxRows;

    function countSetBits(n) {
        let count = 0;
        while (n > 0) {
            n &= (n - 1);
            count++;
        }
        return count;
    }
};