var maximumCount = function(nums) {
    let positiveCount = 0;
    let negativeCount = 0;

    for (let num of nums) {
        if (num > 0) {
            positiveCount++;
        } else if (num < 0) {
            negativeCount++;
        }
    }

    return Math.max(positiveCount, negativeCount);
};