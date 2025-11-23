var subtractProductAndSum = function(n) {
    let product = 1;
    let sum = 0;
    while (n > 0) {
        const digit = n % 10;
        product *= digit;
        sum += digit;
        n = Math.floor(n / 10);
    }
    return product - sum;
};