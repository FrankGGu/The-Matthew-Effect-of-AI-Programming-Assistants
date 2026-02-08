var orchestraLayout = function(n, x, y) {
    let k = Math.min(x, n - x + 1, y, n - y + 1);
    let result = (k - 1) % 9 + 1;
    return result;
};