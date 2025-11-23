var purchasePlans = function(nums, target) {
    nums.sort((a, b) => a - b);
    let left = 0;
    let right = nums.length - 1;
    let count = 0;
    while (left < right) {
        if (nums[left] + nums[right] <= target) {
            count = (count + (right - left)) % 1000000007;
            left++;
        } else {
            right--;
        }
    }
    return count;
};