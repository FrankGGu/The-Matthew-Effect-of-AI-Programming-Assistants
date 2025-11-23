var pivotInteger = function(n) {
    let totalSum = (n * (n + 1)) / 2;
    let currentSum = 0;
    for (let i = 1; i <= n; i++) {
        currentSum += i;
        if (currentSum === totalSum - currentSum + i) {
            return i;
        }
    }
    return -1;
};