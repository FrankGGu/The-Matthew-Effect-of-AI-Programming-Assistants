function longestEvenOddSubarray(nums, threshold) {
    let maxLen = 0;
    let n = nums.length;

    for (let i = 0; i < n; i++) {
        if (nums[i] > threshold) continue;
        let len = 1;
        let prevParity = nums[i] % 2;
        for (let j = i + 1; j < n; j++) {
            if (nums[j] > threshold) break;
            let currParity = nums[j] % 2;
            if (currParity !== prevParity) {
                len++;
                prevParity = currParity;
            } else {
                break;
            }
        }
        maxLen = Math.max(maxLen, len);
    }

    return maxLen;
}