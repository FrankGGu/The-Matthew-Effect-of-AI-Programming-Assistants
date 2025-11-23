function numSubmatrixSumTarget(target, matrix) {
    const rows = matrix.length;
    const cols = matrix[0].length;

    for (let r = 0; r < rows; r++) {
        for (let c = 1; c < cols; c++) {
            matrix[r][c] += matrix[r][c - 1];
        }
    }

    let count = 0;

    for (let c1 = 0; c1 < cols; c1++) {
        for (let c2 = c1; c2 < cols; c2++) {
            const map = new Map();
            map.set(0, 1);
            let sum = 0;

            for (let r = 0; r < rows; r++) {
                sum += matrix[r][c2] - (c1 > 0 ? matrix[r][c1 - 1] : 0);
                count += map.get(sum - target) || 0;
                map.set(sum, (map.get(sum) || 0) + 1);
            }
        }
    }

    return count;
}