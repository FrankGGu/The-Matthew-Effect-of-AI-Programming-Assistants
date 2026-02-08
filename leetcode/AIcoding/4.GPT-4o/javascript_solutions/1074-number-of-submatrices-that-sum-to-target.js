var numSubmatrixSumTarget = function(matrix, target) {
    const rows = matrix.length;
    const cols = matrix[0].length;
    let count = 0;

    for (let left = 0; left < cols; left++) {
        const sums = new Array(rows).fill(0);
        for (let right = left; right < cols; right++) {
            for (let r = 0; r < rows; r++) {
                sums[r] += matrix[r][right];
            }
            const map = new Map();
            map.set(0, 1);
            let currSum = 0;

            for (const sum of sums) {
                currSum += sum;
                if (map.has(currSum - target)) {
                    count += map.get(currSum - target);
                }
                map.set(currSum, (map.get(currSum) || 0) + 1);
            }
        }
    }
    return count;
};