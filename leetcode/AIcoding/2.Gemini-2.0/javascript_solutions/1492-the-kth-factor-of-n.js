var kthFactor = function(n, k) {
    let factors = [];
    for (let i = 1; i <= n; i++) {
        if (n % i === 0) {
            factors.push(i);
        }
    }

    if (k > factors.length) {
        return -1;
    } else {
        return factors[k - 1];
    }
};