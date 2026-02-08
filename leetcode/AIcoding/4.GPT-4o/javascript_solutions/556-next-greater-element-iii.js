var nextGreaterElement = function(n) {
    let nums = Array.from(String(n), Number);
    let i = nums.length - 2;

    while (i >= 0 && nums[i] >= nums[i + 1]) {
        i--;
    }
    if (i < 0) return -1;

    let j = nums.length - 1;
    while (nums[j] <= nums[i]) {
        j--;
    }

    [nums[i], nums[j]] = [nums[j], nums[i]];
    let result = parseInt(nums.slice(0, i + 1).concat(nums.slice(i + 1).reverse()).join(''), 10);

    return result <= 2 ** 31 - 1 ? result : -1;
};