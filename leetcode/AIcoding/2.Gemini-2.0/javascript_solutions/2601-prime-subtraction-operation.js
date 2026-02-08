var primeSubOperation = function(nums) {
    const n = nums.length;
    const primes = [];
    const isPrime = new Array(1001).fill(true);
    isPrime[0] = isPrime[1] = false;

    for (let i = 2; i <= 1000; i++) {
        if (isPrime[i]) {
            primes.push(i);
            for (let j = i * i; j <= 1000; j += i) {
                isPrime[j] = false;
            }
        }
    }

    let prev = 0;
    for (let i = 0; i < n; i++) {
        let bestPrime = 0;
        for (const p of primes) {
            if (nums[i] - p > prev && nums[i] - p < nums[i]) {
                bestPrime = p;
            }
        }

        if (bestPrime === 0) {
            if (nums[i] <= prev) {
                return false;
            }
            prev = nums[i];
        } else {
            prev = nums[i] - bestPrime;
        }
    }

    return true;
};