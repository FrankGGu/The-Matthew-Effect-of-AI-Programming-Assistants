var minimumReplacement = function(nums) {
    let count = 0;
    let prev = nums[nums.length - 1];

    for (let i = nums.length - 2; i >= 0; i--) {
        if (nums[i] > prev) {
            const parts = Math.ceil(nums[i] / prev);
            count += parts - 1;
            prev = Math.floor(nums[i] / parts);
        } else {
            prev = nums[i];
        }
    }

    return count;
};