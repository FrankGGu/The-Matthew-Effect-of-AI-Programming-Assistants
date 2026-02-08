const MAX_BITS = 60; 
const C = Array(MAX_BITS + 1).fill(0).map(() => Array(MAX_BITS + 1).fill(0));

for (let i = 0; i <= MAX_BITS; i++) {
    C[i][0] = 1;
    for (let j = 1; j <= i; j++) {
        C[i][j] = C[i - 1][j - 1] + C[i - 1][j];
    }
}

function countSetBitsUpToN(n, targetBits) {
    if (targetBits < 0) return 0;
    let count = 0;
    let currentSetBits = 0; 

    // Iterate from the most significant possible bit down to the least significant bit.
    for (let i = MAX_BITS; i >= 0; i--) {
        // Check if the i-th bit of n is set.
        if ((n >> i) & 1) {
            // If the i-th bit of n is 1, we have two choices for the current bit:
            // 1. Set the current bit to 0:
            //    This forms numbers that are strictly less than n.
            //    We need `targetBits - currentSetBits` more set bits from the remaining `i` positions.
            if (targetBits - currentSetBits >= 0) {
                count += C[i][targetBits - currentSetBits];
            }

            // 2. Set the current bit to 1:
            //    This forms numbers that match n's prefix up to this bit.
            //    We increment `currentSetBits` and continue to the next lower bit.
            currentSetBits++;
        }
    }

    // After the loop, `currentSetBits` holds the number of set bits in `n` itself.
    // If `n` itself has exactly `targetBits` set bits, we add 1 to the count.
    if (currentSetBits === targetBits) {
        count++;
    }

    return count;
}

function calculateTotalPrices(n) {
    if (n === 0) return 0;
    let totalPrices = 0;

    // Iterate through all possible number of set bits (popcount) from 1 to MAX_BITS.
    for (let b = 1; b <= MAX_BITS; b++) {
        // Get the count of numbers from 1 to n with exactly 'b' set bits.
        // countSetBitsUpToN counts from 0 to n. Since 0 has 0 set bits,
        // it doesn't affect counts for b >= 1. So, this is effectively 1 to n.
        const numCount = countSetBitsUpToN(n, b);

        let pricePerNum;
        if (b % 2 === 1) { // If popcount 'b' is odd
            pricePerNum = b;
        } else { // If popcount 'b' is even
            pricePerNum = b * 2;
        }
        totalPrices += numCount * pricePerNum;
    }
    return totalPrices;
}

var maxRunTime = function(k) {
    let low = 0;
    // The maximum possible value for x.
    // If all prices were 1, x could be up to k (10^15).
    // A safe upper bound is chosen to be slightly larger than k.
    // 2 * 10^15 is a good upper bound, as k is 10^15.
    let high = 2 * 10**15; 
    let ans = 0;

    // Binary search to find the maximum x such that calculateTotalPrices(x) <= k.
    while (low <= high) {
        const mid = low + Math.floor((high - low) / 2);

        // Calculate the sum of prices up to 'mid'.
        const currentSum = calculateTotalPrices(mid);

        if (currentSum <= k) {
            // If the sum is within budget, 'mid' is a possible answer.
            // Try for a larger 'x'.
            ans = mid;
            low = mid + 1;
        } else {
            // If the sum exceeds budget, 'mid' is too large.
            // Try for a smaller 'x'.
            high = mid - 1;
        }
    }
    return ans;
};