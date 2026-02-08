var minimizeMax = function(nums, p) {
    nums.sort((a, b) => a - b);

    let left = 0;
    let right = nums[nums.length - 1] - nums[0];
    let result = right;

    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let count = 0;
        let i = 0;

        while (i < nums.length - 1) {
            if (nums[i + 1] - nums[i] <= mid) {
                count++;
                i += 2;
            } else {
                i++;
            }
        }

        if (count >= p) {
            result = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return result;
};