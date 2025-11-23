var paintingPlan = function(n, k) {
    if (k === 0) return 1;
    if (k === n * n) return 1;
    let res = 0;
    for (let i = 0; i <= n; i++) {
        for (let j = 0; j <= n; j++) {
            if (i * n + j * n - i * j === k) {
                res += comb(n, i) * comb(n, j);
            }
        }
    }
    return res;
};

function comb(n, k) {
    if (k === 0 || k === n) return 1;
    let res = 1;
    for (let i = 1; i <= k; i++) {
        res = res * (n - k + i) / i;
    }
    return res;
}