var findPrimePairs = function(n) {
    const isPrime = (num) => {
        if (num <= 1) return false;
        for (let i = 2; i * i <= num; i++) {
            if (num % i === 0) return false;
        }
        return true;
    }

    const result = [];
    for (let i = 2; i <= n / 2; i++) {
        if (isPrime(i) && isPrime(n - i)) {
            result.push([i, n - i]);
        }
    }
    return result;
};