var minSubarray = function(nums, p) {
    let totalSum = 0;
    for (let num of nums) {
        totalSum = (totalSum + num) % p;
    }

    if (totalSum === 0) {
        return 0;
    }

    const targetRemainder = totalSum;
    let minLen = nums.length; 
    let currentPrefixSumRemainder = 0;
    const remainderMap = new Map();
    remainderMap.set(0, -1);

    for (let i = 0; i < nums.length; i++) {
        currentPrefixSumRemainder = (currentPrefixSumRemainder + nums[i]) % p;

        const requiredRemainderForPrevPrefix = (currentPrefixSumRemainder - targetRemainder + p) % p;

        if (remainderMap.has(requiredRemainderForPrevPrefix)) {
            const prevIndex = remainderMap.get(requiredRemainderForPrevPrefix);
            minLen = Math.min(minLen, i - prevIndex);
        }

        remainderMap.set(currentPrefixSumRemainder, i);
    }

    if (minLen === nums.length) {
        return -1;
    } else {
        return minLen;
    }
};