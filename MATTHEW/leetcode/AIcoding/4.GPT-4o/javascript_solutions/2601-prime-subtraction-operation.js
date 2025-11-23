var primeSubOperation = function(nums) {
    const isPrime = (num) => {
        if (num <= 1) return false;
        for (let i = 2; i * i <= num; i++) {
            if (num % i === 0) return false;
        }
        return true;
    };

    const primes = [];
    for (let i = 2; i < 1000; i++) {
        if (isPrime(i)) primes.push(i);
    }

    const n = nums.length;
    let lastNum = Infinity;

    for (let i = n - 1; i >= 0; i--) {
        let found = false;
        for (let j = 0; j < primes.length; j++) {
            if (nums[i] - primes[j] > lastNum) {
                continue;
            } else if (nums[i] - primes[j] > 0) {
                nums[i] -= primes[j];
                lastNum = nums[i];
                found = true;
                break;
            }
        }
        if (!found) return false;
    }
    return true;
};