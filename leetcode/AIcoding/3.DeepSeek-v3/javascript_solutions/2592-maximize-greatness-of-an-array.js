var maximizeGreatness = function(nums) {
    nums.sort((a, b) => a - b);
    let i = 0, j = 0, count = 0;
    const n = nums.length;
    while (j < n) {
        if (nums[j] > nums[i]) {
            count++;
            i++;
        }
        j++;
    }
    return count;
};