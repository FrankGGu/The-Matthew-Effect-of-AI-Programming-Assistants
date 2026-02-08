var distinctPrimeFactors = function(nums) {
    const getPrimes = (n) => {
        const primes = new Set();
        for (let i = 2; i * i <= n; i++) {
            while (n % i === 0) {
                primes.add(i);
                n = Math.floor(n / i);
            }
        }
        if (n > 1) {
            primes.add(n);
        }
        return primes;
    };

    const primeSet = new Set();
    for (const num of nums) {
        const primes = getPrimes(num);
        for (const p of primes) {
            primeSet.add(p);
        }
    }
    return primeSet.size;
};