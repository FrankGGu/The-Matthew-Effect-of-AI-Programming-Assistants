var maxSumTwoNoOverlap = function(nums, firstLen, secondLen) {
    const n = nums.length;
    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    let maxFirst = 0, maxSecond = 0, result = 0;

    for (let i = firstLen + secondLen; i <= n; i++) {
        maxFirst = Math.max(maxFirst, prefixSum[i - secondLen] - prefixSum[i - secondLen - firstLen]);
        result = Math.max(result, maxFirst + prefixSum[i] - prefixSum[i - secondLen]);
    }

    for (let i = firstLen + secondLen; i <= n; i++) {
        maxSecond = Math.max(maxSecond, prefixSum[i - firstLen] - prefixSum[i - firstLen - secondLen]);
        result = Math.max(result, maxSecond + prefixSum[i] - prefixSum[i - firstLen]);
    }

    return result;
};