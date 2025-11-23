var countCompleteSubarrays = function(nums) {
    const distinct = new Set(nums).size;
    let count = 0;
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        const current = new Set();
        for (let j = i; j < n; j++) {
            current.add(nums[j]);
            if (current.size === distinct) {
                count += n - j;
                break;
            }
        }
    }

    return count;
};