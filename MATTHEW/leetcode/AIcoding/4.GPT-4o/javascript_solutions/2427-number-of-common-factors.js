var commonFactors = function(a, b) {
    let count = 0;
    const gcd = (x, y) => y === 0 ? x : gcd(y, x % y);
    const g = gcd(a, b);
    for (let i = 1; i <= g; i++) {
        if (g % i === 0) count++;
    }
    return count;
};