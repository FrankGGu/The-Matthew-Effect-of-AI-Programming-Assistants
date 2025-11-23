var findPrimePairs = function(n) {
    const isPrime = (num) => {
        if (num <= 1) return false;
        if (num === 2) return true;
        if (num % 2 === 0) return false;
        for (let i = 3; i <= Math.sqrt(num); i += 2) {
            if (num % i === 0) return false;
        }
        return true;
    };

    const result = [];
    for (let x = 2; x <= n / 2; x++) {
        const y = n - x;
        if (isPrime(x) && isPrime(y)) {
            result.push([x, y]);
        }
    }
    return result;
};