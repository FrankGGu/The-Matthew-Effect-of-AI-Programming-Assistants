var concatenatedBinary = function(n) {
    let res = 0;
    let mod = 10**9 + 7;
    let len = 0;
    for (let i = 1; i <= n; i++) {
        if ((i & (i - 1)) === 0) {
            len++;
        }
        res = ((res << len) % mod + i) % mod;
    }
    return res;
};