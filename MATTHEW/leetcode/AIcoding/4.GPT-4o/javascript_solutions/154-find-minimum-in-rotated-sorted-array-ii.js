var findMin = function(nums) {
    let left = 0, right = nums.length - 1;
    while (left < right) {
        while (right > left && nums[right] === nums[right - 1]) right--;
        while (left < right && nums[left] === nums[left + 1]) left++;
        const mid = Math.floor((left + right) / 2);
        if (nums[mid] > nums[right]) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return nums[left];
};