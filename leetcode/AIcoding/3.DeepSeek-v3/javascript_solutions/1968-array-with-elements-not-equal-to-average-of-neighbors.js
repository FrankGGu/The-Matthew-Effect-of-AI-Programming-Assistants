var rearrangeArray = function(nums) {
    nums.sort((a, b) => a - b);
    let res = [];
    let left = 0, right = nums.length - 1;
    while (left <= right) {
        if (left === right) {
            res.push(nums[left]);
        } else {
            res.push(nums[left]);
            res.push(nums[right]);
        }
        left++;
        right--;
    }
    return res;
};