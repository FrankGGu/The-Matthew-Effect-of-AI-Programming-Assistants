var closestPrimes = function(left, right) {
    function isPrime(num) {
        if (num <= 1) return false;
        if (num === 2) return true;
        if (num % 2 === 0) return false;
        for (let i = 3; i <= Math.sqrt(num); i += 2) {
            if (num % i === 0) return false;
        }
        return true;
    }

    let primes = [];
    for (let i = left; i <= right; i++) {
        if (isPrime(i)) {
            primes.push(i);
        }
    }

    if (primes.length < 2) {
        return [-1, -1];
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