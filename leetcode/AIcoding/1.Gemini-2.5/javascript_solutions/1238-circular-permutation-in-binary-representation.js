var circularPermutation = function(n, start) {
    const result = [];
    const totalNumbers = 1 << n;

    for (let i = 0; i < totalNumbers; i++) {
        const grayCode = i ^ (i >> 1);
        result.push(grayCode ^ start);
    }

    return result;
};