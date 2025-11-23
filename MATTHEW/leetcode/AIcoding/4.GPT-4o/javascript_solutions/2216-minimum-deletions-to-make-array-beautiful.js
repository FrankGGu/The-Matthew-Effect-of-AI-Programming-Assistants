var minimumDeletions = function(nums) {
    let deletions = 0;
    let n = nums.length;

    for (let i = 0; i < n; i++) {
        if (i % 2 === 1 && nums[i] < nums[i - 1]) {
            deletions++;
        } else if (i % 2 === 0 && nums[i] > nums[i - 1]) {
            deletions++;
        }
    }

    return deletions;
};