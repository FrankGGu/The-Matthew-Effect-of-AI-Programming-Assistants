var maximizeGreatness = function(nums) {
    nums.sort((a, b) => a - b);
    let count = 0;
    let j = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] > nums[j]) {
            count++;
            j++;
        }
    }
    return count;
};