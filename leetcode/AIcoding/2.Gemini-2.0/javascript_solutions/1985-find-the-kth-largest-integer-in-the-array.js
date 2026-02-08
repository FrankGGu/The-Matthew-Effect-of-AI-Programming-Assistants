var kthLargestNumber = function(nums, k) {
    nums.sort((a, b) => {
        if (a.length !== b.length) {
            return a.length - b.length;
        } else {
            return a.localeCompare(b);
        }
    });
    return nums[nums.length - k];
};