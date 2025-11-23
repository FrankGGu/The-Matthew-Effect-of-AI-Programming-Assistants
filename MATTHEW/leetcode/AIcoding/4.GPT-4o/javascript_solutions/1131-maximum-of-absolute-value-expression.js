var maxAbsValExpr = function(arr1, arr2) {
    let maxVal = 0;
    for (let i = 0; i < 4; i++) {
        let sign1 = (i & 1) === 0 ? 1 : -1;
        let sign2 = (i & 2) === 0 ? 1 : -1;
        let currentMax = -Infinity;
        let currentMin = Infinity;
        for (let j = 0; j < arr1.length; j++) {
            let value = sign1 * arr1[j] + sign2 * arr2[j] + j;
            currentMax = Math.max(currentMax, value);
            currentMin = Math.min(currentMin, value);
        }
        maxVal = Math.max(maxVal, currentMax - currentMin);
    }
    return maxVal;
};