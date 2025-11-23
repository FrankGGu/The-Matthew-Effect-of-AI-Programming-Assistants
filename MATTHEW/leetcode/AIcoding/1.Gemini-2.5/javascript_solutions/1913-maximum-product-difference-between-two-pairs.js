var maxProductDifference = function(nums) {
    nums.sort((a, b) => a - b);
    const n = nums.length;

    // The two largest numbers will be at the end of the sorted array
    const max1 = nums[n - 1];
    const max2 = nums[n - 2];

    // The two smallest numbers will be at the beginning of the sorted array
    const min1 = nums[0];
    const min2 = nums[1];

    return (max1 * max2) - (min1 * min2);
};