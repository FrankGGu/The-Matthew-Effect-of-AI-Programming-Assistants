var partitionDisjoint = function(nums) {
    let n = nums.length;
    let maxLeft = new Array(n);
    let minRight = new Array(n);

    let max = nums[0];
    for (let i = 0; i < n; i++) {
        max = Math.max(max, nums[i]);
        maxLeft[i] = max;
    }

    let min = nums[n - 1];
    for (let i = n - 1; i >= 0; i--) {
        min = Math.min(min, nums[i]);
        minRight[i] = min;
    }

    for (let i = 1; i < n; i++) {
        if (maxLeft[i - 1] <= minRight[i]) {
            return i;
        }
    }

    return -1;
};