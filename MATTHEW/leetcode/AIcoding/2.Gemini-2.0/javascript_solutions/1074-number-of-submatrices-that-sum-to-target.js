var numSubmatrixSumTarget = function(matrix, target) {
    let rows = matrix.length;
    let cols = matrix[0].length;
    let count = 0;

    for (let i = 0; i < rows; i++) {
        for (let j = 1; j < cols; j++) {
            matrix[i][j] += matrix[i][j - 1];
        }
    }

    for (let c1 = 0; c1 < cols; c1++) {
        for (let c2 = c1; c2 < cols; c2++) {
            let map = new Map();
            map.set(0, 1);
            let sum = 0;
            for (let i = 0; i < rows; i++) {
                let rowSum = 0;
                if (c1 === 0) {
                    rowSum = matrix[i][c2];
                } else {
                    rowSum = matrix[i][c2] - matrix[i][c1 - 1];
                }
                sum += rowSum;
                if (map.has(sum - target)) {
                    count += map.get(sum - target);
                }
                map.set(sum, (map.get(sum) || 0) + 1);
            }
        }
    }

    return count;
};