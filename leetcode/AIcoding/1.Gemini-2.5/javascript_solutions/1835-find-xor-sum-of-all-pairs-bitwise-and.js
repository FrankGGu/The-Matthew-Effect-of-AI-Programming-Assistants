var getXORSum = function(arr1, arr2) {
    let xorSum1 = 0;
    for (let i = 0; i < arr1.length; i++) {
        xorSum1 ^= arr1[i];
    }

    let xorSum2 = 0;
    for (let i = 0; i < arr2.length; i++) {
        xorSum2 ^= arr2[i];
    }

    return xorSum1 & xorSum2;
};