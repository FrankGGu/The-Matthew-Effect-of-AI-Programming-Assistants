var maxFrequencyAfterOperation = function(nums) {
    let maxFreq = 0;
    let currentFreq = 1;
    let maxNum = nums[0];

    for (let i = 1; i < nums.length; i++) {
        if (nums[i] === nums[i - 1]) {
            currentFreq++;
        } else {
            currentFreq = 1;
        }
        if (currentFreq > maxFreq) {
            maxFreq = currentFreq;
            maxNum = nums[i];
        }
    }

    let count = 0;
    for (let num of nums) {
        if (num === maxNum) {
            count++;
        }
    }

    return count;
};