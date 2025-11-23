var maxSumTwoNoOverlap = function(nums, firstLen, secondLen) {
    const n = nums.length;

    const maxSum = (firstLen, secondLen) => {
        let maxFirst = 0;
        let firstSum = 0;
        for (let i = 0; i < firstLen; i++) {
            firstSum += nums[i];
        }
        maxFirst = firstSum;

        let secondSum = 0;
        for (let i = firstLen; i < firstLen + secondLen; i++) {
            secondSum += nums[i];
        }
        let maxSum = maxFirst + secondSum;

        for (let i = firstLen; i < n - secondLen; i++) {
            firstSum += nums[i] - nums[i - firstLen];
            maxFirst = Math.max(maxFirst, firstSum);
            secondSum += nums[i + secondLen] - nums[i];
            maxSum = Math.max(maxSum, maxFirst + secondSum);
        }

        return maxSum;
    };

    return Math.max(maxSum(firstLen, secondLen), maxSum(secondLen, firstLen));
};