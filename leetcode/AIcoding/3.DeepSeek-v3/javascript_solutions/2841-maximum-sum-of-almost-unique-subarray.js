var maxSum = function(nums, m, k) {
    let maxSum = 0;
    let currentSum = 0;
    const frequency = new Map();
    let left = 0;

    for (let right = 0; right < nums.length; right++) {
        const num = nums[right];
        frequency.set(num, (frequency.get(num) || 0) + 1);
        currentSum += num;

        while (right - left + 1 > k) {
            const leftNum = nums[left];
            frequency.set(leftNum, frequency.get(leftNum) - 1);
            if (frequency.get(leftNum) === 0) {
                frequency.delete(leftNum);
            }
            currentSum -= leftNum;
            left++;
        }

        if (right - left + 1 === k && frequency.size >= m) {
            maxSum = Math.max(maxSum, currentSum);
        }
    }

    return maxSum;
};