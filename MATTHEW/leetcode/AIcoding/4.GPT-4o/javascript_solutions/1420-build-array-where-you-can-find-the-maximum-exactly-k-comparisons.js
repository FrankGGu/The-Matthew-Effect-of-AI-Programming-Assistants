var maxArray = function(n, m, k) {
    if (k < n - 1 || k > m) return [];
    let result = [];
    for (let i = 1; i <= n; i++) {
        result.push(i);
    }
    for (let i = 0; i < k - (n - 1); i++) {
        result.push(m - i);
    }
    return result;
};