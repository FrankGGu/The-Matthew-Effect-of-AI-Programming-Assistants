var diagonalPrime = function(nums) {
    const n = nums.length;
    let maxPrime = 0;

    const isPrime = (num) => {
        if (num <= 1) return false;
        if (num === 2) return true;
        if (num % 2 === 0) return false;
        for (let i = 3; i <= Math.sqrt(num); i += 2) {
            if (num % i === 0) return false;
        }
        return true;
    };

    for (let i = 0; i < n; i++) {
        const num1 = nums[i][i];
        const num2 = nums[i][n - 1 - i];
        if (isPrime(num1) {
            maxPrime = Math.max(maxPrime, num1);
        }
        if (isPrime(num2)) {
            maxPrime = Math.max(maxPrime, num2);
        }
    }

    return maxPrime;
};