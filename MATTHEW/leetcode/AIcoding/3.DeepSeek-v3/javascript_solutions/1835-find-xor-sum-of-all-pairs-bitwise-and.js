var getXORSum = function(arr1, arr2) {
    let xor1 = 0;
    for (let num of arr1) {
        xor1 ^= num;
    }
    let xor2 = 0;
    for (let num of arr2) {
        xor2 ^= num;
    }
    return xor1 & xor2;
};