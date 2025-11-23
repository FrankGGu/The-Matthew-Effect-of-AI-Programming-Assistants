var countBits = function(n) {
    const res = new Array(n + 1);
    for (let i = 0; i <= n; i++) {
        res[i] = res[i >> 1] + (i & 1);
    }
    return res;
};