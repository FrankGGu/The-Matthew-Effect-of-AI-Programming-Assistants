var distinctPrimeFactors = function(nums) {
    const primes = new Set();

    const getPrimeFactors = (num) => {
        const factors = new Set();
        let divisor = 2;
        while (num >= 2) {
            if (num % divisor === 0) {
                factors.add(divisor);
                num = num / divisor;
            } else {
                divisor++;
            }
        }
        return factors;
    };

    for (const num of nums) {
        const factors = getPrimeFactors(num);
        for (const factor of factors) {
            primes.add(factor);
        }
    }

    return primes.size;
};