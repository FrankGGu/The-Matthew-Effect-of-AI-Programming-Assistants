var diagonalPrime = function(nums) {
    const n = nums.length;
    let maxPrime = 0;

    const isPrime = (num) => {
        if (num <= 1) {
            return false;
        }
        if (num <= 3) {
            return true;
        }
        if (num % 2 === 0 || num % 3 === 0) {
            return false;
        }
        for (let i = 5; i * i <= num; i = i + 6) {
            if (num % i === 0 || num % (i + 2) === 0) {
                return false;
            }
        }
        return true;
    };

    for (let i = 0; i < n; i++) {
        // Main diagonal
        const val1 = nums[i][i];
        if (isPrime(val1) && val1 > maxPrime) {
            maxPrime = val1;
        }

        // Anti-diagonal
        const val2 = nums[i][n - 1 - i];
        if (isPrime(val2) && val2 > maxPrime) {
            maxPrime = val2;
        }
    }

    return maxPrime;
};