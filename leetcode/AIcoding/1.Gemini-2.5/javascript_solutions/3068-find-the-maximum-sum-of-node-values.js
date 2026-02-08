var maximumValueSum = function(nums, k, edges) {
    let currentSum = 0;
    let xorCount = 0;
    let minPositiveGain = Infinity;
    let maxNegativeGain = -Infinity;

    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        const xorNum = num ^ k;
        const gain = xorNum - num;

        if (gain >= 0) {
            currentSum += xorNum;
            xorCount++;
            minPositiveGain = Math.min(minPositiveGain, gain);
        } else {
            currentSum += num;
            maxNegativeGain = Math.max(maxNegativeGain, gain);
        }
    }

    if (xorCount % 2 === 0) {
        return currentSum;
    } else {
        return Math.max(currentSum - minPositiveGain, currentSum + maxNegativeGain);
    }
};