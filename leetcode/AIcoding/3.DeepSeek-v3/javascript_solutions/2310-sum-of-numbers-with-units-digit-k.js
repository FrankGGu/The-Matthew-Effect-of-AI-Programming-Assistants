var minimumNumbers = function(num, k) {
    if (num === 0) return 0;
    let sum = 0;
    for (let i = 1; i <= 10; i++) {
        sum = i * k;
        if (sum > num) break;
        if (sum % 10 === num % 10) {
            return i;
        }
    }
    return -1;
};