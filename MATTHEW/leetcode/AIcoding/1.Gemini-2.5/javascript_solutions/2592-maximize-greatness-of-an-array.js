var maximizeGreatness = function(nums) {
    nums.sort((a, b) => a - b);
    let greatness = 0;
    let i = 0; 
    for (let j = 0; j < nums.length; j++) {
        if (nums[j] > nums[i]) {
            greatness++;
            i++;
        }
    }
    return greatness;
};