var countSubarrays = function(nums, k) {
    let count = 0;
    let n = nums.length;
    for (let i = 0; i < n; i++) {
        let currentAnd = nums[i];
        if (currentAnd === k) {
            count++;
        }
        for (let j = i + 1; j < n; j++) {
            currentAnd &= nums[j];
            if (currentAnd === k) {
                count++;
            }
            if (currentAnd < k) {
                break;
            }
        }
    }
    return count;
};