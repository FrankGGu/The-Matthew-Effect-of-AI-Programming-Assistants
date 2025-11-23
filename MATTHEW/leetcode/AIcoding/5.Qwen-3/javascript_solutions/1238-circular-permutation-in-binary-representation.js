function circularPermutation(n, start) {
    const result = [];
    for (let i = 0; i < 1 << n; i++) {
        result.push(i ^ (i >> 1));
    }
    const index = result.indexOf(start);
    const rotated = result.slice(index).concat(result.slice(0, index));
    return rotated;
}