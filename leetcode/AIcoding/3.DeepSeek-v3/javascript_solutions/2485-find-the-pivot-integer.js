var pivotInteger = function(n) {
    let totalSum = n * (n + 1) / 2;
    let leftSum = 0;
    for (let x = 1; x <= n; x++) {
        leftSum += x;
        if (leftSum === totalSum - leftSum + x) {
            return x;
        }
    }
    return -1;
};