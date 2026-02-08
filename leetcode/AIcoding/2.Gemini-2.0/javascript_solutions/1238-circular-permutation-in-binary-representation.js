var circularPermutation = function(n, start) {
    const result = [];
    for (let i = 0; i < (1 << n); i++) {
        result.push(i ^ (i >> 1));
    }

    let startIndex = result.indexOf(start);
    const rotatedResult = result.slice(startIndex).concat(result.slice(0, startIndex));

    return rotatedResult;
};