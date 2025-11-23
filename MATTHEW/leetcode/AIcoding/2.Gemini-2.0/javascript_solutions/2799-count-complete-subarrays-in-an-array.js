var countCompleteSubarrays = function(nums) {
    const distinctNums = new Set(nums).size;
    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        const seen = new Set();
        for (let j = i; j < nums.length; j++) {
            seen.add(nums[j]);
            if (seen.size === distinctNums) {
                count++;
            }
        }
    }
    return count;
};