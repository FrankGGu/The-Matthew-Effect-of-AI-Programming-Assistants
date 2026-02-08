var commonFactors = function(a, b) {
    let count = 0;
    const min = Math.min(a, b);
    for (let i = 1; i <= min; i++) {
        if (a % i === 0 && b % i === 0) {
            count++;
        }
    }
    return count;
};