var maximumPrimeDifference = function(nums) {
    const isPrime = (n) => {
        if (n <= 1) return false;
        for (let i = 2; i <= Math.sqrt(n); i++) {
            if (n % i === 0) return false;
        }
        return true;
    };

    let primes = [];
    for (let num of nums) {
        if (isPrime(num)) {
            primes.push(num);
        }
    }

    if (primes.length < 2) return -1;

    let maxDiff = -1;
    for (let i = 0; i < primes.length; i++) {
        for (let j = i + 1; j < primes.length; j++) {
            maxDiff = Math.max(maxDiff, Math.abs(primes[i] - primes[j]));
        }
    }

    return maxDiff;
};