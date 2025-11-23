var countCompleteSubarrays = function(nums) {
    const n = nums.length;
    const uniqueCount = new Set(nums).size;
    let count = 0;

    for (let i = 0; i < n; i++) {
        const seen = new Set();
        for (let j = i; j < n; j++) {
            seen.add(nums[j]);
            if (seen.size === uniqueCount) {
                count++;
            }
        }
    }

    return count;
};