var maxAbsValExpr = function(arr1, arr2) {
    const n = arr1.length;
    let maxVal = 0;

    const signs = [
        [1, 1, 1],
        [1, 1, -1],
        [1, -1, 1],
        [1, -1, -1],
        [-1, 1, 1],
        [-1, 1, -1],
        [-1, -1, 1],
        [-1, -1, -1]
    ];

    for (const [s1, s2, s3] of signs) {
        let currentMin = Infinity;
        let currentMax = -Infinity;

        for (let k = 0; k < n; k++) {
            const val = s1 * arr1[k] + s2 * arr2[k] + s3 * k;
            currentMin = Math.min(currentMin, val);
            currentMax = Math.max(currentMax, val);
        }
        maxVal = Math.max(maxVal, currentMax - currentMin);
    }

    return maxVal;
};