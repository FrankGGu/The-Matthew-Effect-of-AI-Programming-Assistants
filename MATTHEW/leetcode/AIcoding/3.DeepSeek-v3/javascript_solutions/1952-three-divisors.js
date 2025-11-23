var isThree = function(n) {
    if (n === 1) return false;
    let count = 2; // 1 and n
    for (let i = 2; i <= Math.sqrt(n); i++) {
        if (n % i === 0) {
            if (i * i === n) {
                count++;
            } else {
                count += 2;
            }
        }
        if (count > 3) return false;
    }
    return count === 3;
};