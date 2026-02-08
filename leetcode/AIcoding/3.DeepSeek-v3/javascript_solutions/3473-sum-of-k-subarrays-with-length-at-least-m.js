var maxSum = function(nums, m, k) {
    let maxSum = 0;
    let currentSum = 0;
    let uniqueCount = 0;
    const frequencyMap = new Map();

    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        currentSum += num;
        frequencyMap.set(num, (frequencyMap.get(num) || 0) + 1);
        if (frequencyMap.get(num) === 1) {
            uniqueCount++;
        }

        if (i >= k) {
            const leftNum = nums[i - k];
            currentSum -= leftNum;
            frequencyMap.set(leftNum, frequencyMap.get(leftNum) - 1);
            if (frequencyMap.get(leftNum) === 0) {
                uniqueCount--;
            }
        }

        if (i >= k - 1 && uniqueCount >= m) {
            maxSum = Math.max(maxSum, currentSum);
        }
    }

    return maxSum;
};