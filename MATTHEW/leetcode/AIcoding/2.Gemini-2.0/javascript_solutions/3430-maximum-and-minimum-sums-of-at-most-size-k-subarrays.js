var maximumAndMinimumSubsumsK = function(nums, k) {
    const n = nums.length;
    let maxSum = -Infinity;
    let minSum = Infinity;

    for (let i = 0; i < n; i++) {
        let currentMax = 0;
        let currentMin = 0;

        for (let j = i; j < Math.min(i + k, n); j++) {
            currentMax += nums[j];
            currentMin += nums[j];

            maxSum = Math.max(maxSum, currentMax);
            minSum = Math.min(minSum, currentMin);
        }

        let currentMax2 = 0;
        let currentMin2 = 0;
        for (let len = 1; len <= k; len++) {
            if (i + len <= n) {
                currentMax2 = 0;
                currentMin2 = 0;
                for (let j = i; j < i + len; j++) {
                    currentMax2 += nums[j];
                    currentMin2 += nums[j];
                }
                maxSum = Math.max(maxSum, currentMax2);
                minSum = Math.min(minSum, currentMin2);
            }
        }

    }

    if (k > n) {
        let sum = 0;
        for (let num of nums) {
            sum += num
        }
        maxSum = Math.max(maxSum, sum)
        minSum = Math.min(minSum, sum)
    }

    return [maxSum, minSum];
};