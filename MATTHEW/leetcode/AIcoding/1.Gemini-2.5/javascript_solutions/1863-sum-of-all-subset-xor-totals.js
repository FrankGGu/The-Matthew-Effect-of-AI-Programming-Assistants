var subsetXORSum = function(nums) {
    let totalSum = 0;
    const n = nums.length;

    // The maximum value in nums is 20 (10100 in binary), so we only need to check bits up to the 4th position.
    // (i.e., bits 0, 1, 2, 3, 4).
    // A safe upper bound for iteration is 5 (for j = 0 to 4).
    const maxRelevantBit = 5; 

    for (let j = 0; j < maxRelevantBit; j++) {
        let count_j = 0; // Counts how many numbers in nums have the j-th bit set
        for (let i = 0; i < n; i++) {
            if ((nums[i] >> j) & 1) {
                count_j++;
            }
        }

        // If at least one number in nums has the j-th bit set (count_j > 0),
        // then exactly 2^(n-1) subsets will have their j-th bit set in their XOR total.
        // The contribution of this bit position to the overall sum of XOR totals is (2^j) * 2^(n-1).
        if (count_j > 0) {
            totalSum += (1 << j) * (1 << (n - 1));
        }
    }

    return totalSum;
};