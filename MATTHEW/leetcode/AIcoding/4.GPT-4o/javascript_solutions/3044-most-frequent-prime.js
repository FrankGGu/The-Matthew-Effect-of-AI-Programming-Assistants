var mostFrequentPrime = function(nums) {
    const isPrime = (n) => {
        if (n < 2) return false;
        for (let i = 2; i * i <= n; i++) {
            if (n % i === 0) return false;
        }
        return true;
    };

    const primeCount = {};

    for (const num of nums) {
        if (isPrime(num)) {
            primeCount[num] = (primeCount[num] || 0) + 1;
        }
    }

    let maxCount = 0;
    let mostFrequent = -1;

    for (const [prime, count] of Object.entries(primeCount)) {
        if (count > maxCount || (count === maxCount && prime < mostFrequent)) {
            maxCount = count;
            mostFrequent = +prime;
        }
    }

    return mostFrequent;
};