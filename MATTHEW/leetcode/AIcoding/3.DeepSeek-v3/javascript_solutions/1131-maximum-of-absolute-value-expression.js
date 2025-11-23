var maxAbsValExpr = function(arr1, arr2) {
    let max1 = -Infinity, max2 = -Infinity, max3 = -Infinity, max4 = -Infinity;
    let min1 = Infinity, min2 = Infinity, min3 = Infinity, min4 = Infinity;

    for (let i = 0; i < arr1.length; i++) {
        let val1 = arr1[i] + arr2[i] + i;
        let val2 = arr1[i] - arr2[i] + i;
        let val3 = -arr1[i] + arr2[i] + i;
        let val4 = -arr1[i] - arr2[i] + i;

        max1 = Math.max(max1, val1);
        min1 = Math.min(min1, val1);

        max2 = Math.max(max2, val2);
        min2 = Math.min(min2, val2);

        max3 = Math.max(max3, val3);
        min3 = Math.min(min3, val3);

        max4 = Math.max(max4, val4);
        min4 = Math.min(min4, val4);
    }

    return Math.max(max1 - min1, max2 - min2, max3 - min3, max4 - min4);
};