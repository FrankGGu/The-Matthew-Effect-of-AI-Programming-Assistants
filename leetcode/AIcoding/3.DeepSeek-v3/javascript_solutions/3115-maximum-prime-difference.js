var maximumPrimeDifference = function(nums) {
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
    for (let i = 0; i < nums.length; i++) {
        if (isPrime(nums[i])) {
            primes.push(i);
        }
    }

    if (primes.length < 2) return 0;
    return primes[primes.length - 1] - primes[0];
};