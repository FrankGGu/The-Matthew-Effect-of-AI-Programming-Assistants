var paintingPlan = function(n, m, k) {
    if (k > n * n) return 0;
    if (k < 0) return 0;
    if (n === 0) return 0;
    if (n === 1) {
        if (k === m) return 1;
        else return 0;
    }

    let count = 0;
    for (let i = 0; i <= n; i++) {
        for (let j = 0; j <= n; j++) {
            if (i * n + j * n - i * j === k) {
                count += combination(n, i) * combination(n, j);
            }
        }
    }
    return count;

    function combination(n, k) {
        if (k < 0 || k > n) return 0;
        if (k === 0 || k === n) return 1;
        if (k > n / 2) k = n - k;
        let res = 1;
        for (let i = 1; i <= k; i++) {
            res = res * (n - i + 1) / i;
        }
        return res;
    }
};