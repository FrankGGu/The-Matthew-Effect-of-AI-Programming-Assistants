var distinctAverages = function(nums) {
    nums.sort((a, b) => a - b);
    let set = new Set();
    let left = 0;
    let right = nums.length - 1;

    while (left < right) {
        let avg = (nums[left] + nums[right]) / 2;
        set.add(avg);
        left++;
        right--;
    }

    return set.size;
};