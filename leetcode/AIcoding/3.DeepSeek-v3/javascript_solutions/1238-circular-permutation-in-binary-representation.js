var circularPermutation = function(n, start) {
    const grayCode = [];
    for (let i = 0; i < (1 << n); i++) {
        grayCode.push(i ^ (i >> 1));
    }
    const index = grayCode.indexOf(start);
    return grayCode.slice(index).concat(grayCode.slice(0, index));
};