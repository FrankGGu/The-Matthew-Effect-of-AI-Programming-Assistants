var minOperations = function(n) {
    let k = Math.floor(n / 2);
    return k * (k + (n % 2));
};