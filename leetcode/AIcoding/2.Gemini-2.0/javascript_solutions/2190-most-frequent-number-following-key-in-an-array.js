var mostFrequent = function(nums, key) {
    const counts = {};
    for (let i = 0; i < nums.length - 1; i++) {
        if (nums[i] === key) {
            if (counts[nums[i+1]] === undefined) {
                counts[nums[i+1]] = 0;
            }
            counts[nums[i+1]]++;
        }
    }

    let mostFrequentNum = -1;
    let maxCount = 0;
    for (const num in counts) {
        if (counts[num] > maxCount) {
            maxCount = counts[num];
            mostFrequentNum = parseInt(num);
        }
    }

    return mostFrequentNum;
};