function findMaxLength(nums) {
    let countMap = new Map();
    countMap.set(0, -1);
    let maxLength = 0, count = 0;

    for (let i = 0; i < nums.length; i++) {
        count += nums[i] === 1 ? 1 : -1;

        if (countMap.has(count)) {
            maxLength = Math.max(maxLength, i - countMap.get(count));
        } else {
            countMap.set(count, i);
        }
    }

    return maxLength;
}