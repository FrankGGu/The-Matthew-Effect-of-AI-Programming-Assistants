var canSortArray = function(nums) {
    // Helper function to count set bits (popcount) using Brian Kernighan's algorithm.
    // This algorithm efficiently counts the number of set bits in a positive integer.
    function countSetBits(n) {
        let count = 0;
        while (n > 0) {
            n &= (n - 1); // This operation clears the least significant set bit.
            count++;
        }
        return count;
    }

    // The maximum value for nums[i] is 10^9.
    // 2^29 is 536,870,912
    // 2^30 is 1,073,741,824
    // So, a number up to 10^9 can have at most 30 set bits (e.g., 2^30 - 1).
    // We need an array to store the maximum value encountered so far for each possible bit count.
    // The indices of this array will represent the bit counts (from 0 to 30).
    // Initialize with 0, as all numbers in nums are positive (>= 1).
    const MAX_POSSIBLE_BITS = 30; 
    const maxValForBitCount = new Array(MAX_POSSIBLE_BITS + 1).fill(0);

    // Iterate through the input array nums.
    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        const currentBitCount = countSetBits(num);

        // For the current number `num` at index `i`, we check if it violates the sorting condition.
        // The condition for sortability is:
        // If two numbers `nums[p]` and `nums[q]` have different bit counts, and `p < q`,
        // then it must be that `nums[p] <= nums[q]`.
        // If `nums[p] > nums[q]`, and their bit counts are different, they cannot be swapped
        // to correct their relative order, making the array unsortable.

        // We iterate through all possible bit counts `k`.
        for (let k = 0; k <= MAX_POSSIBLE_BITS; k++) {
            // We only care about `k` values that are different from `currentBitCount`.
            if (k !== currentBitCount) {
                // `maxValForBitCount[k]` stores the maximum number encountered so far (at an index `p < i`)
                // that has `k` set bits.
                // If this `maxValForBitCount[k]` is greater than the current `num`,
                // then we have found a pair (maxValForBitCount[k], num) such that:
                // 1. maxValForBitCount[k] appeared before num (its index `p` < `i`).
                // 2. Their bit counts are different (`k` != `currentBitCount`).
                // 3. maxValForBitCount[k] > num.
                // This violates the sorting condition, so we return false.
                if (maxValForBitCount[k] > num) {
                    return false;
                }
            }
        }

        // After checking, update the maximum value seen for the `currentBitCount`.
        // This ensures `maxValForBitCount[currentBitCount]` always holds the largest
        // number with `currentBitCount` bits encountered up to the current index `i`.
        maxValForBitCount[currentBitCount] = Math.max(maxValForBitCount[currentBitCount], num);
    }

    // If the loop completes without returning false, it means no such problematic pair was found.
    // Therefore, the array can be sorted.
    return true;
};