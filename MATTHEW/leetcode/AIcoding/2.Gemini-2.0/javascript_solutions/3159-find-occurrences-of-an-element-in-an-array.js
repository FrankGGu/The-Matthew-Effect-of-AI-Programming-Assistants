var findOccurrences = function(nums, target) {
    const occurrences = [];
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] === target) {
            occurrences.push(i);
        }
    }
    return occurrences;
};