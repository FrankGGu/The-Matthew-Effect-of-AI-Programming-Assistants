var countBits = function(n) {
    const result = new Array(n + 1);
    for (let i = 0; i <= n; i++) {
        result[i] = (i.toString(2).match(/1/g) || []).length;
    }
    return result;
};