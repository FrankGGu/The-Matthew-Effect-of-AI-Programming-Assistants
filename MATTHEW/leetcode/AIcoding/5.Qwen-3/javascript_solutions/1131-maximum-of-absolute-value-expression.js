function maxAbsValExpr(arr1, arr2) {
    let max = 0;
    const n = arr1.length;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const val = Math.abs(arr1[i] - arr1[j]) + Math.abs(arr2[i] - arr2[j]);
            if (val > max) {
                max = val;
            }
        }
    }
    return max;
}