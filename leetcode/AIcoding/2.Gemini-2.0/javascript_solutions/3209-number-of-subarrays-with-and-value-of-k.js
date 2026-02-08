var countSubarrays = function(nums, k) {
    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        let currentAnd = nums[i];
        if (currentAnd === k) {
            count++;
        }
        for (let j = i + 1; j < nums.length; j++) {
            currentAnd &= nums[j];
            if (currentAnd === k) {
                count++;
            }
        }
    }
    return count;
};