var maximizeGreatness = function(nums) {
    nums.sort((a, b) => a - b);
    let greatness = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] > greatness) {
            greatness++;
        }
    }
    return greatness;
};