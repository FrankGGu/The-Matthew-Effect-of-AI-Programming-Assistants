var subsetsWithDup = function(nums) {
    nums.sort((a, b) => a - b);
    const result = [[]];
    let startIndex = 0;
    let endIndex = 0;

    for (let i = 0; i < nums.length; i++) {
        startIndex = 0;
        if (i > 0 && nums[i] === nums[i - 1]) {
            startIndex = endIndex + 1;
        }
        endIndex = result.length - 1;
        for (let j = startIndex; j <= endIndex; j++) {
            const subset = [...result[j]];
            subset.push(nums[i]);
            result.push(subset);
        }
    }

    return result;
};