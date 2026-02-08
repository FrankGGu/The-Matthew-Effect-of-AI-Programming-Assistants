var sumFourDivisors = function(nums) {
    let totalSum = 0;

    for (const num of nums) {
        const divisors = new Set();
        for (let i = 1; i <= Math.sqrt(num); i++) {
            if (num % i === 0) {
                divisors.add(i);
                divisors.add(num / i);
                if (divisors.size > 4) break;
            }
        }
        if (divisors.size === 4) {
            totalSum += [...divisors].reduce((sum, val) => sum + val, 0);
        }
    }

    return totalSum;
};