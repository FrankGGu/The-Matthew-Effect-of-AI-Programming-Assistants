var closestPrimes = function(left, right) {
    const isPrime = (num) => {
        if (num < 2) return false;
        for (let i = 2; i * i <= num; i++) {
            if (num % i === 0) return false;
        }
        return true;
    };

    let primes = [];
    for (let i = left; i <= right; i++) {
        if (isPrime(i)) primes.push(i);
    }

    let minDiff = Infinity;
    let result = [-1, -1];

    for (let i = 1; i < primes.length; i++) {
        const diff = primes[i] - primes[i - 1];
        if (diff < minDiff) {
            minDiff = diff;
            result = [primes[i - 1], primes[i]];
        }
    }

    return result;
};