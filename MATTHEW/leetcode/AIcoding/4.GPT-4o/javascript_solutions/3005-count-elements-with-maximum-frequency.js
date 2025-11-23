var countMaxFrequency = function(nums) {
    const frequency = {};
    let maxCount = 0;

    for (const num of nums) {
        frequency[num] = (frequency[num] || 0) + 1;
        if (frequency[num] > maxCount) {
            maxCount = frequency[num];
        }
    }

    return Object.values(frequency).filter(count => count === maxCount).length;
};