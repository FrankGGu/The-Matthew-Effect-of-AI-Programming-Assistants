var countPairs = function(nums, k) {
    const gcd = (a, b) => {
        while (b) {
            [a, b] = [b, a % b];
        }
        return a;
    };

    const getDivisors = (n) => {
        const divisors = new Set();
        for (let i = 1; i * i <= n; i++) {
            if (n % i === 0) {
                divisors.add(i);
                divisors.add(n / i);
            }
        }
        return Array.from(divisors);
    };

    const kDivisors = getDivisors(k);
    const freqMap = new Map();
    for (const d of kDivisors) {
        freqMap.set(d, 0);
    }

    let count = 0;

    for (const num of nums) {
        const commonDivisor = gcd(num, k);
        const requiredMultiple = k / commonDivisor;

        // Count pairs with previous numbers
        // We need nums[j] such that (nums[j] * num) % k == 0
        // This is equivalent to nums[j] % (k / gcd(num, k)) == 0
        // So, we need to find previous nums[j] that are multiples of requiredMultiple
        // The freqMap stores counts of previous numbers divisible by its keys (divisors of k)
        count += freqMap.get(requiredMultiple);

        // Update freqMap for the current num
        for (const d of kDivisors) {
            if (num % d === 0) {
                freqMap.set(d, freqMap.get(d) + 1);
            }
        }
    }

    return count;
};