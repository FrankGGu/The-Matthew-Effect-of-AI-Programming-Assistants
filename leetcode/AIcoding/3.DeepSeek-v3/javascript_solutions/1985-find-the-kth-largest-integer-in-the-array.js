var kthLargestNumber = function(nums, k) {
    nums.sort((a, b) => {
        if (a.length !== b.length) {
            return b.length - a.length;
        }
        return b.localeCompare(a);
    });
    return nums[k - 1];
};