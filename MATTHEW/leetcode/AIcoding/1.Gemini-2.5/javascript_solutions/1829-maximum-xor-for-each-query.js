var getMaximumXor = function(nums, maximumBit) {
    const n = nums.length;
    const result = [];
    let currentXORSum = 0;
    // The mask represents (2^maximumBit - 1), which is a number with 'maximumBit' ones.
    // For example, if maximumBit is 3, mask is 111 (binary) or 7 (decimal).
    const mask = (1 << maximumBit) - 1;

    // Calculate the XOR sum of all elements in the initial array.
    // This will be the XOR sum for the first query (nums[0] ^ ... ^ nums[n-1]).
    for (let i = 0; i < n; i++) {
        currentXORSum ^= nums[i];
    }

    // Process queries in reverse order of array length, as specified.
    // The problem asks for queries from i = n-1 down to 0.
    // This means the first query is for nums[0]...nums[n-1], the second for nums[0]...nums[n-2], and so on.
    for (let i = n - 1; i >= 0; i--) {
        // At this point, currentXORSum holds the XOR sum of nums[0] ^ ... ^ nums[i].
        // We need to find a non-negative integer k such that (currentXORSum ^ k) is maximized,
        // and 0 <= k < 2^maximumBit.
        //
        // Since all nums[j] are less than 2^maximumBit, their XOR sum (currentXORSum)
        // will also be less than 2^maximumBit. This means currentXORSum only has bits set
        // up to position maximumBit - 1.
        //
        // To maximize currentXORSum ^ k, we want the result to have '1's in all bit positions
        // from 0 to maximumBit - 1. This target value is exactly 'mask'.
        // So we want currentXORSum ^ k = mask.
        // Solving for k: k = currentXORSum ^ mask.
        const k = currentXORSum ^ mask;
        result.push(k);

        // For the next query (which involves a shorter prefix, nums[0] ^ ... ^ nums[i-1]),
        // we need to remove nums[i] from the currentXORSum.
        // The property of XOR is that A ^ B ^ B = A.
        // So, currentXORSum ^ nums[i] effectively removes nums[i] from the sum.
        currentXORSum ^= nums[i];
    }

    return result;
};