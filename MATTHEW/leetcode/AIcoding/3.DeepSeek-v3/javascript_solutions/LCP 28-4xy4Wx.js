var purchasePlans = function(nums, target) {
    nums.sort((a, b) => a - b);
    let left = 0;
    let right = nums.length - 1;
    let res = 0;
    const mod = 1e9 + 7;

    while (left < right) {
        if (nums[left] + nums[right] > target) {
            right--;
        } else {
            res += right - left;
            res %= mod;
            left++;
        }
    }

    return res % mod;
};