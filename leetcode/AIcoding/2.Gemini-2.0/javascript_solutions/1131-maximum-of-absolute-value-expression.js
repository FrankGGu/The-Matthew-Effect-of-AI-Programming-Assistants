var maxAbsValExpr = function(arr1, arr2) {
    let n = arr1.length;
    let max1 = -Infinity, min1 = Infinity;
    let max2 = -Infinity, min2 = Infinity;
    let max3 = -Infinity, min3 = Infinity;
    let max4 = -Infinity, min4 = Infinity;

    for (let i = 0; i < n; i++) {
        max1 = Math.max(max1, arr1[i] + arr2[i] + i);
        min1 = Math.min(min1, arr1[i] + arr2[i] + i);

        max2 = Math.max(max2, arr1[i] + arr2[i] - i);
        min2 = Math.min(min2, arr1[i] + arr2[i] - i);

        max3 = Math.max(max3, arr1[i] - arr2[i] + i);
        min3 = Math.min(min3, arr1[i] - arr2[i] + i);

        max4 = Math.max(max4, arr1[i] - arr2[i] - i);
        min4 = Math.min(min4, arr1[i] - arr2[i] - i);
    }

    return Math.max(max1 - min1, max2 - min2, max3 - min3, max4 - min4);
};