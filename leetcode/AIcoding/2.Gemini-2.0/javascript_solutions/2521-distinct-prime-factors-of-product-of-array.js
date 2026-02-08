var distinctPrimeFactors = function(nums) {
    const primes = new Set();
    for (const num of nums) {
        let n = num;
        for (let i = 2; i * i <= n; i++) {
            while (n % i === 0) {
                primes.add(i);
                n /= i;
            }
        }
        if (n > 1) {
            primes.add(n);
        }
    }
    return primes.size;
};