var minimumOperations = function(nums) {
    if (nums.length === 1) return 0;

    const freqEven = new Map();
    const freqOdd = new Map();

    for (let i = 0; i < nums.length; i++) {
        if (i % 2 === 0) {
            freqEven.set(nums[i], (freqEven.get(nums[i]) || 0) + 1);
        } else {
            freqOdd.set(nums[i], (freqOdd.get(nums[i]) || 0) + 1);
        }
    }

    const evenEntries = Array.from(freqEven.entries()).sort((a, b) => b[1] - a[1]);
    const oddEntries = Array.from(freqOdd.entries()).sort((a, b) => b[1] - a[1]);

    let maxEven = evenEntries[0][0];
    let maxEvenCount = evenEntries[0][1];
    let secondMaxEvenCount = evenEntries.length > 1 ? evenEntries[1][1] : 0;

    let maxOdd = oddEntries[0][0];
    let maxOddCount = oddEntries[0][1];
    let secondMaxOddCount = oddEntries.length > 1 ? oddEntries[1][1] : 0;

    if (maxEven !== maxOdd) {
        return nums.length - maxEvenCount - maxOddCount;
    } else {
        const option1 = nums.length - maxEvenCount - secondMaxOddCount;
        const option2 = nums.length - secondMaxEvenCount - maxOddCount;
        return Math.min(option1, option2);
    }
};