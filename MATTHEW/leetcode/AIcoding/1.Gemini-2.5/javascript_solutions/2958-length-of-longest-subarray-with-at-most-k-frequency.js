var maxSubarrayLength = function(nums, k) {
    let left = 0;
    let maxLength = 0;
    const frequencyMap = new Map();

    for (let right = 0; right < nums.length; right++) {
        const num = nums[right];
        frequencyMap.set(num, (frequencyMap.get(num) || 0) + 1);

        while (frequencyMap.get(num) > k) {
            const leftNum = nums[left];
            frequencyMap.set(leftNum, frequencyMap.get(leftNum) - 1);
            left++;
        }

        maxLength = Math.max(maxLength, right - left + 1);
    }

    return maxLength;
};