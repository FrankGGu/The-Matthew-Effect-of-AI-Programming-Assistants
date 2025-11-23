var maximumNumberOfStringPairs = function(nums) {
    nums.sort((a, b) => a - b);
    let count = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] > i + 1) continue;
        let happy = true;
        for (let j = 0; j < nums.length; j++) {
            if (i === j) continue;
            if (nums[j] <= i + 1) happy = false;
        }
        if (happy) count++;
    }
    return count;
};