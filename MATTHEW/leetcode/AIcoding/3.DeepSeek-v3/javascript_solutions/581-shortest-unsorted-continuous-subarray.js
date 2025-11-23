var findUnsortedSubarray = function(nums) {
    let n = nums.length;
    let left = 0, right = n - 1;

    while (left < n - 1 && nums[left] <= nums[left + 1]) {
        left++;
    }

    if (left === n - 1) return 0;

    while (right > 0 && nums[right] >= nums[right - 1]) {
        right--;
    }

    let min = Infinity, max = -Infinity;
    for (let i = left; i <= right; i++) {
        min = Math.min(min, nums[i]);
        max = Math.max(max, nums[i]);
    }

    while (left > 0 && nums[left - 1] > min) {
        left--;
    }

    while (right < n - 1 && nums[right + 1] < max) {
        right++;
    }

    return right - left + 1;
};