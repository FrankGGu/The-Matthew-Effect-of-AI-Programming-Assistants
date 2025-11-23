var maxPrimeDiff = function(A) {
    const isPrime = num => {
        if (num < 2) return false;
        for (let i = 2; i * i <= num; i++) {
            if (num % i === 0) return false;
        }
        return true;
    };

    const primes = [];
    for (let i = 2; i <= 1000000; i++) {
        if (isPrime(i)) primes.push(i);
    }

    let maxDiff = -1;
    for (let i = 0; i < A.length; i++) {
        for (let j = 0; j < primes.length; j++) {
            if (primes[j] > A[i]) break;
            for (let k = primes.length - 1; k >= 0; k--) {
                if (primes[k] < A[i]) break;
                maxDiff = Math.max(maxDiff, primes[k] - primes[j]);
            }
        }
    }

    return maxDiff;
};