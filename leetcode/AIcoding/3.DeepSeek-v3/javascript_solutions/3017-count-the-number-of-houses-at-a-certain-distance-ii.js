var countOfPairs = function(n, x, y) {
    let res = new Array(n).fill(0);
    if (x > y) [x, y] = [y, x];
    for (let i = 1; i <= n; i++) {
        for (let j = i + 1; j <= n; j++) {
            let d = Math.min(j - i, Math.abs(i - x) + 1 + Math.abs(j - y));
            res[d - 1] += 2;
        }
    }
    return res;
};