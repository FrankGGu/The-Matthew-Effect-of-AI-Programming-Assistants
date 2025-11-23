var triangleType = function(nums) {
    nums.sort((a, b) => a - b);
    if (nums[0] + nums[1] <= nums[2]) {
        return "Not A Triangle";
    }
    if (nums[0] === nums[1] && nums[1] === nums[2]) {
        return "Equilateral";
    } else if (nums[0] === nums[1] || nums[1] === nums[2] || nums[0] === nums[2]) {
        return "Isosceles";
    } else {
        return "Scalene";
    }
};