var makeTheIntegerZero = function(num1, num2) {
    for (let k = 1; k <= 60; k++) {
        let target = num1 - k * num2;
        if (target < 0) continue;
        let bits = countBits(target);
        if (bits <= k && k <= target) {
            return k;
        }
    }
    return -1;
};

function countBits(n) {
    let count = 0;
    while (n > 0) {
        count += n & 1;
        n = n >> 1;
    }
    return count;
}