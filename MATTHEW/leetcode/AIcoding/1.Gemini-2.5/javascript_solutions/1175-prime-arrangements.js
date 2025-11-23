var numPrimeArrangements = function(n) {
    const MOD = 10**9 + 7;

    function isPrime(num) {
        if (num <= 1) {
            return false;
        }
        for (let i = 2; i * i <= num; i++) {
            if (num % i === 0) {
                return false;
            }
        }
        return true;
    }

    let primeCount = 0;
    for (let i = 1; i <= n; i++) {
        if (isPrime(i)) {
            primeCount++;
        }
    }

    let nonPrimeCount = n - primeCount;

    function calculateFactorial(k) {
        let res = 1;
        for (let i = 2; i <= k; i++) {
            res = (res * i) % MOD;
        }
        return res;
    }

    let primeFactorial = calculateFactorial(primeCount);
    let nonPrimeFactorial = calculateFactorial(nonPrimeCount);

    return (primeFactorial * nonPrimeFactorial) % MOD;
};