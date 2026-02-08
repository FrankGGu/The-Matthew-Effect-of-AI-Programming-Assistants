var minArrayEnd = function(n, x) {
    let res = x;
    for (let i = 1; i < n; i++) {
        res = (res | (res + 1)) & ((1 << 30) - 1);
    }
    return res;
};