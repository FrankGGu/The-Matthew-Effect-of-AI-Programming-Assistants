var minSwaps = function(nums) {
    const ones = nums.reduce((acc, num) => acc + num, 0);
    if (ones === 0 || ones === nums.length) return 0;

    const circularNums = [...nums, ...nums];
    let maxOnesInWindow = 0;
    let currentOnes = 0;

    for (let i = 0; i < ones; i++) {
        currentOnes += circularNums[i];
    }
    maxOnesInWindow = currentOnes;

    for (let i = ones; i < circularNums.length; i++) {
        currentOnes += circularNums[i] - circularNums[i - ones];
        maxOnesInWindow = Math.max(maxOnesInWindow, currentOnes);
    }

    return ones - maxOnesInWindow;
};