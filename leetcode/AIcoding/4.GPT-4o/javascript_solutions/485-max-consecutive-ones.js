var findMaxConsecutiveOnes = function(nums) {
    let maxCount = 0, currentCount = 0;
    for (let num of nums) {
        if (num === 1) {
            currentCount++;
            maxCount = Math.max(maxCount, currentCount);
        } else {
            currentCount = 0;
        }
    }
    return maxCount;
};