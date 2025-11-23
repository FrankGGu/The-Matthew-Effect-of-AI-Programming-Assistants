function mostFrequent(nums, key) {
    const count = {};
    let maxFreq = 0;
    let result = nums[0];

    for (let i = 0; i < nums.length - 1; i++) {
        if (nums[i] === key) {
            const nextNum = nums[i + 1];
            count[nextNum] = (count[nextNum] || 0) + 1;
            if (count[nextNum] > maxFreq) {
                maxFreq = count[nextNum];
                result = nextNum;
            }
        }
    }

    return result;
}