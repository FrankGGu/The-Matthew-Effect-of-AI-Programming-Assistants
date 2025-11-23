var countOrders = function(n) {
    let result = 1;
    for (let i = 2; i <= n; i++) {
        result = result * (2 * i - 1) * i;
    }
    return result;
};