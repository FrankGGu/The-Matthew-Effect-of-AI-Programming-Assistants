var rearrangeArray = function(nums) {
    nums.sort((a, b) => a - b);
    let n = nums.length;
    let result = new Array(n);
    let left = 0;
    let right = n - 1;
    for (let i = 0; i < n; i++) {
        if (i % 2 === 0) {
            result[i] = nums[left];
            left++;
        } else {
            result[i] = nums[right];
            right--;
        }
    }
    return result;
};