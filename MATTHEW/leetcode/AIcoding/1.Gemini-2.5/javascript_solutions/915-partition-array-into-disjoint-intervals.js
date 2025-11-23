var partitionDisjoint = function(nums) {
    const n = nums.length;
    const maxLeft = new Array(n);
    const minRight = new Array(n);

    maxLeft[0] = nums[0];
    for (let i = 1; i < n; i++) {
        maxLeft[i] = Math.max(maxLeft[i - 1], nums[i]);
    }

    minRight[n - 1] = nums[n - 1];
    for (let i = n - 2; i >= 0; i--) {
        minRight[i] = Math.min(minRight[i + 1], nums[i]);
    }

    for (let i = 0; i < n - 1; i++) {
        if (maxLeft[i] <= minRight[i + 1]) {
            return i + 1;
        }
    }

    return -1;
};