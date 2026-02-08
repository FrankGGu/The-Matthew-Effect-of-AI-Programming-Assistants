function countBalancedPermutations(n) {
    const MOD = 1e9 + 7;
    const factorial = (x) => {
        let result = 1;
        for (let i = 2; i <= x; i++) {
            result = (result * i) % MOD;
        }
        return result;
    };

    if (n % 2 !== 0) return 0;
    const half = n / 2;
    return (factorial(n) * modularInverse(factorial(half)) % MOD * modularInverse(factorial(half)) % MOD) % MOD;
}

function modularInverse(a) {
    const MOD = 1e9 + 7;
    return power(a, MOD - 2, MOD);
}

function power(x, y, p) {
    let res = 1; 
    x = x % p; 
    while (y > 0) {
        if (y & 1) {
            res = (res * x) % p;
        }
        y = y >> 1; 
        x = (x * x) % p; 
    }
    return res;
}