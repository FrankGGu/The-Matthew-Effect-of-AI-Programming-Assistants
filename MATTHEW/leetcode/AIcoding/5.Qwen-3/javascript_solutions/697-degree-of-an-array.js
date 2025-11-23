function findShortestSubArray(nums) {
    const count = {};
    const firstOccur = {};
    const lastOccur = {};

    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        if (!count[num]) {
            count[num] = 1;
            firstOccur[num] = i;
        } else {
            count[num]++;
        }
        lastOccur[num] = i;
    }

    let minLength = Infinity;
    let maxCount = 0;

    for (const num in count) {
        if (count[num] > maxCount) {
            maxCount = count[num];
            minLength = lastOccur[num] - firstOccur[num] + 1;
        } else if (count[num] === maxCount) {
            minLength = Math.min(minLength, lastOccur[num] - firstOccur[num] + 1);
        }
    }

    return minLength;
}