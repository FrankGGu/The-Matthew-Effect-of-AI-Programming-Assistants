var findKthLargest = function(nums, k) {
    nums.sort((a, b) => parseInt(b) - parseInt(a));
    return nums[k - 1];
};