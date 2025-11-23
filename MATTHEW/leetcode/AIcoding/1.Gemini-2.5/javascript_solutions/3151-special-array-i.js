var specialArray = function(nums) {
    const n = nums.length;

    for (let x = 0; x <= n; x++) {
        let count = 0;
        for (let i = 0; i < n; i++) {
            if (nums[i] >= x) {
                count++;
            }
        }
        if (count === x) {
            return x;
        }
    }

    return -1;
};