const MAX_VAL = 1000000;
const spf = new Array(MAX_VAL + 1).fill(0);

function sieve() {
    for (let i = 2; i <= MAX_VAL; i++) {
        if (spf[i] === 0) { // i is prime (0 indicates not visited yet)
            spf[i] = i;
            // Mark multiples of i. Start from i*i because smaller multiples (e.g., 2*i, 3*i)
            // would have already been marked by smaller prime factors (2, 3, etc.).
            for (let j = i * i; j <= MAX_VAL; j += i) {
                if (spf[j] === 0) { // Only set spf[j] if it hasn't been set by a smaller prime factor
                    spf[j] = i;
                }
            }
        }
    }
}

function getPrimeFactors(n) {
    const factors = new Set();
    if (n <= 1) { // 1 has no prime factors
        return factors;
    }
    while (n > 1) {
        factors.add(spf[n]);
        n /= spf[n];
    }
    return factors;
}

var findSplitPoint = function(nums) {
    sieve(); // Precompute spf array once

    const n = nums.length;
    if (n === 1) {
        return -1; // No valid split point for an array of length 1
    }

    // Maps to store counts of distinct prime factors for the left and right products
    const leftPrimeFactorsMap = new Map(); // prime -> count in nums[0...i]
    const rightPrimeFactorsMap = new Map(); // prime -> count in nums[i+1...n-1]

    // Initially, all numbers are on the right side. Populate rightPrimeFactorsMap.
    for (let i = 0; i < n; i++) {
        const pfs = getPrimeFactors(nums[i]);
        for (const p of pfs) {
            rightPrimeFactorsMap.set(p, (rightPrimeFactorsMap.get(p) || 0) + 1);
        }
    }

    let sharedPrimeFactorsCount = 0; // Tracks the number of distinct primes present in both left and right products

    // Iterate through possible split points 'i' from 0 to n-2
    for (let i = 0; i < n - 1; i++) {
        const currentNum = nums[i];
        const pfs = getPrimeFactors(currentNum);

        // Move prime factors of currentNum from the right product to the left product
        for (const p of pfs) {
            // 1. Update rightPrimeFactorsMap: Decrement count for prime 'p'
            rightPrimeFactorsMap.set(p, rightPrimeFactorsMap.get(p) - 1);

            // If count of 'p' in right product becomes 0, it means 'p' is no longer on the right side.
            // If 'p' was previously shared (i.e., also present on the left), it's no longer shared.
            if (rightPrimeFactorsMap.get(p) === 0) {
                if (leftPrimeFactorsMap.has(p)) { 
                    sharedPrimeFactorsCount--;
                }
            }

            // 2. Update leftPrimeFactorsMap: Increment count for prime 'p'
            // If 'p' is new to the left side (count becomes 1), check if it becomes shared.
            if (!leftPrimeFactorsMap.has(p)) { // 'p' just appeared on the left side
                leftPrimeFactorsMap.set(p, 1);
                // If 'p' is also still present on the right side (count > 0), it becomes shared.
                if (rightPrimeFactorsMap.get(p) > 0) {
                    sharedPrimeFactorsCount++;
                }
            } else { // 'p' was already on the left side, just increment its count
                leftPrimeFactorsMap.set(p, leftPrimeFactorsMap.get(p) + 1);
                // No change to sharedPrimeFactorsCount here, as its shared status doesn't change
                // by merely incrementing its count on the left (it was already on the left).
            }
        }

        // After processing nums[i], if sharedPrimeFactorsCount is 0, it means
        // the left product and right product are coprime.
        if (sharedPrimeFactorsCount === 0) {
            return i; // Return the smallest such split point
        }
    }

    // If the loop completes without finding a valid split point, return -1.
    return -1;
};