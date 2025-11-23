var circularPermutation = function(n, start) {
    const result = [];
    for (let i = 0; i < (1 << n); i++) {
        result.push((i ^ (i >> 1)) ^ start);
    }
    return result;
};