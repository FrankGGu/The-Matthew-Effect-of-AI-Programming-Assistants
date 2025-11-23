var minimizeMax = function(nums, p) {
    nums.sort((a, b) => a - b);
    let left = 0, right = nums[nums.length - 1] - nums[0];

    while (left < right) {
        let mid = Math.floor((left + right) / 2);
        let count = 0;
        for (let i = 0; i < nums.length - 1; i++) {
            if (nums[i + 1] - nums[i] <= mid) {
                count++;
                i++;
            }
        }
        if (count >= p) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
};