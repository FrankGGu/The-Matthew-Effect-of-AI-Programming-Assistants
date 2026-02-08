var isThree = function(n) {
    if (n < 2) return false;
    let count = 0;
    for (let i = 1; i <= Math.sqrt(n); i++) {
        if (n % i === 0) {
            count++;
            if (i !== n / i) count++;
        }
        if (count > 3) return false;
    }
    return count === 3;
};