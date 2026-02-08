var maxNiceDivisors = function(n) {
    if (n <= 3) return n;
    let mod = 1e9 + 7;
    let a = n % 3, b = Math.floor(n / 3);
    if (a === 0) return modPow(3, b, mod);
    if (a === 1) return (modPow(3, b - 1, mod) * 4) % mod;
    return (modPow(3, b, mod) * 2) % mod;
};

function modPow(base, exp, mod) {
    let result = 1;
    while (exp > 0) {
        if (exp % 2 === 1) result = (result * base) % mod;
        base = (base * base) % mod;
        exp = Math.floor(exp / 2);
    }
    return result;
}