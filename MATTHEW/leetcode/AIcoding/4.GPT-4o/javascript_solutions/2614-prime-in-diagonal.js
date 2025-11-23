var diagonalPrime = function(nums) {
    const isPrime = (n) => {
        if (n < 2) return false;
        for (let i = 2; i * i <= n; i++) {
            if (n % i === 0) return false;
        }
        return true;
    };

    let maxPrime = 0;
    for (let i = 0; i < nums.length; i++) {
        if (isPrime(nums[i][i])) {
            maxPrime = Math.max(maxPrime, nums[i][i]);
        }
        if (isPrime(nums[i][nums.length - 1 - i])) {
            maxPrime = Math.max(maxPrime, nums[i][nums.length - 1 - i]);
        }
    }

    return maxPrime;
};