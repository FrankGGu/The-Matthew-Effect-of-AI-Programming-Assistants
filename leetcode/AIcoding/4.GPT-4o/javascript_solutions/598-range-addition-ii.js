var maxCount = function(m, n, ops) {
    let x = m, y = n;
    for (const [a, b] of ops) {
        x = Math.min(x, a);
        y = Math.min(y, b);
    }
    return x * y;
};