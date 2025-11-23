var primePairs = function(n) {
    const isPrime = (num) => {
        if (num < 2) return false;
        for (let i = 2; i * i <= num; i++) {
            if (num % i === 0) return false;
        }
        return true;
    };

    const primes = [];
    for (let i = 2; i <= n; i++) {
        if (isPrime(i)) primes.push(i);
    }

    const result = [];
    const primeSet = new Set(primes);
    for (let p of primes) {
        if (primeSet.has(n - p)) {
            result.push([p, n - p]);
            primeSet.delete(p);
            primeSet.delete(n - p);
        }
    }

    return result;
};