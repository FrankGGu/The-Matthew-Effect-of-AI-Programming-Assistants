var minSizeSubarray = function(nums, target) {
    const totalSum = nums.reduce((a, b) => a + b, 0);
    const n = nums.length;
    let k = Math.floor(target / totalSum);
    let remaining = target % totalSum;
    if (remaining === 0) {
        return k * n;
    }

    let minLen = Infinity;
    let currentSum = 0;
    let left = 0;
    const extendedNums = nums.concat(nums);

    for (let right = 0; right < extendedNums.length; right++) {
        currentSum += extendedNums[right];
        while (currentSum > remaining) {
            currentSum -= extendedNums[left];
            left++;
        }
        if (currentSum === remaining) {
            minLen = Math.min(minLen, right - left + 1);
        }
    }

    return minLen !== Infinity ? minLen + k * n : -1;
};