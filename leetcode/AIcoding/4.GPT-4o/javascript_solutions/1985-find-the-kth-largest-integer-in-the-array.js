var kthLargestNumber = function(nums, k) {
    nums.sort((a, b) => (a.length === b.length ? a.localeCompare(b) : a.length - b.length));
    return nums[nums.length - k];
};