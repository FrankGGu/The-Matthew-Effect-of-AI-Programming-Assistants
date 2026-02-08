var findSubarrays = function(nums) {
    const seenSums = new Set();

    for (let i = 0; i < nums.length - 1; i++) {
        const currentSum = nums[i] + nums[i+1];
        if (seenSums.has(currentSum)) {
            return true;
        }
        seenSums.add(currentSum);
    }

    return false;
};