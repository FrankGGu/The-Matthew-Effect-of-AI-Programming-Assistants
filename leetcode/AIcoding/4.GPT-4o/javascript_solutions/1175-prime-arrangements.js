var numPrimeArrangements = function(n) {
    const mod = 1e9 + 7;
    const isPrime = new Array(n + 1).fill(true);
    isPrime[0] = isPrime[1] = false;

    for (let i = 2; i * i <= n; i++) {
        if (isPrime[i]) {
            for (let j = i * i; j <= n; j += i) {
                isPrime[j] = false;
            }
        }
    }

    let primeCount = 0;
    for (let i = 2; i <= n; i++) {
        if (isPrime[i]) primeCount++;
    }

    const factorial = (num) => {
        let result = 1;
        for (let i = 2; i <= num; i++) {
            result = (result * i) % mod;
        }
        return result;
    };

    return (factorial(primeCount) * factorial(n - primeCount)) % mod;
};