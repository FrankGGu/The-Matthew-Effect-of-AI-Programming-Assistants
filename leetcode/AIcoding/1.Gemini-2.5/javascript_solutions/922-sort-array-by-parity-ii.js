var sortArrayByParityII = function(nums) {
    let j = 1; // Pointer for odd indices
    for (let i = 0; i < nums.length; i += 2) { // Iterate through even indices
        if (nums[i] % 2 === 1) { // If number at even index is odd
            while (nums[j] % 2 === 1) { // Find an even number at an odd index
                j += 2;
            }
            // Swap nums[i] (odd at even index) with nums[j] (even at odd index)
            [nums[i], nums[j]] = [nums[j], nums[i]];
        }
    }
    return nums;
};