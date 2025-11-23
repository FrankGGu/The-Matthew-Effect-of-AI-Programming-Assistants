function countPrimeArrangements(n) {
    const MOD = 1000000007;

    function isPrime(num) {
        if (num < 2) return false;
        for (let i = 2; i * i <= num; i++) {
            if (num % i === 0) return false;
        }
        return true;
    }

    let primeCount = 0;
    for (let i = 2; i <= n; i++) {
        if (isPrime(i)) {
            primeCount++;
        }
    }

    let nonPrimeCount = n - primeCount;

    function factorial(x) {
        let result = 1;
        for (let i = 2; i <= x; i++) {
            result = (result * i) % MOD;
        }
        return result;
    }

    return (factorial(primeCount) * factorial(nonPrimeCount)) % MOD;
}