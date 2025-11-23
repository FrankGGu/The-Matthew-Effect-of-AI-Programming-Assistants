var maximumPrimeDifference = function(nums) {
    const MAX_NUM_VAL = 100;
    const isPrime = new Array(MAX_NUM_VAL + 1).fill(true);
    isPrime[0] = false;
    isPrime[1] = false;

    for (let p = 2; p * p <= MAX_NUM_VAL; p++) {
        if (isPrime[p]) {
            for (let i = p * p; i <= MAX_NUM_VAL; i += p)
                isPrime[i] = false;
        }
    }

    let minPrimeIndex = -1;
    let maxPrimeIndex = -1;

    for (let i = 0; i < nums.length; i++) {
        if (isPrime[nums[i]]) {
            if (minPrimeIndex === -1) {
                minPrimeIndex = i;
            }
            maxPrimeIndex = i;
        }
    }

    return maxPrimeIndex - minPrimeIndex;
};