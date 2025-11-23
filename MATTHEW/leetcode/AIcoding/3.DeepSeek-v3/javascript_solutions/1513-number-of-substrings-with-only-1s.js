var numSub = function(s) {
    const MOD = 1e9 + 7;
    let res = 0;
    let count = 0;

    for (let char of s) {
        if (char === '1') {
            count++;
            res = (res + count) % MOD;
        } else {
            count = 0;
        }
    }

    return res;
};