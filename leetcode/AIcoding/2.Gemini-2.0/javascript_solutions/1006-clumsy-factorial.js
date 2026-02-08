var clumsy = function(n) {
    if (n <= 2) return n;
    if (n <= 4) return n + 3;

    let result = n * (n - 1) / (n - 2) + (n - 3);
    n -= 4;

    while (n > 0) {
        let term = - (n * (n - 1) / (n - 2)) + (n - 3);
        result += term;
        n -= 4;
    }

    return Math.floor(result);
};