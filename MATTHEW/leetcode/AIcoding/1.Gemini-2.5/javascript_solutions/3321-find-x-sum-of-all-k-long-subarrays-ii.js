var findXSumOfAllKLongSubarraysII = function(nums, k) {
    const n = nums.length;
    if (n === 0 || k === 0 || k > n) {
        return 0;
    }

    const dq = [];
    let totalSum = 0;

    for (let i = 0; i < n; i++) {
        while (dq.length > 0 && nums[dq[dq.length - 1]] >= nums[i]) {
            dq.pop();
        }

        dq.push(i);

        if (dq[0] <= i - k) {
            dq.shift();
        }

        if (i >= k - 1) {
            totalSum += nums[dq[0]];
        }
    }

    return totalSum;
};