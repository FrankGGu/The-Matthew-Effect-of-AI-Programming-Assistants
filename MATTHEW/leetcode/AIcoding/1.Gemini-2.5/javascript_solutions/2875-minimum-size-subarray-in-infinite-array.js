var minSizeSubarray = function(nums, target) {
    const n = nums.length;
    let totalSum = 0;
    for (let i = 0; i < n; i++) {
        totalSum += nums[i];
    }

    let minLen = Infinity;

    const numFullCopies = Math.floor(target / totalSum);
    const remainingTarget = target % totalSum;

    // Helper function to find minimum length subarray with a given sum
    // This is a standard sliding window approach for positive numbers
    const findMinLenSubarray = (arr, subTarget) => {
        let currentSum = 0;
        let start = 0;
        let tempMinLen = Infinity;

        for (let end = 0; end < arr.length; end++) {
            currentSum += arr[end];
            while (currentSum >= subTarget) {
                if (currentSum === subTarget) {
                    tempMinLen = Math.min(tempMinLen, end - start + 1);
                }
                currentSum -= arr[start];
                start++;
            }
        }
        return tempMinLen;
    };

    if (remainingTarget === 0) {
        // If target is a multiple of totalSum, the minimum length is simply numFullCopies * n.
        // We cannot achieve a shorter length for the full sum by breaking it down,
        // as the problem requires a single contiguous subarray.
        minLen = numFullCopies * n;
    } else {
        // If there's a remaining target, we need to find a subarray that sums to it.
        // This subarray might wrap around the original `nums` array.
        // So, we search in `nums` concatenated with itself (`extendedNums`).
        const extendedNums = nums.concat(nums);
        const lenForRemainingTarget = findMinLenSubarray(extendedNums, remainingTarget);

        if (lenForRemainingTarget !== Infinity) {
            minLen = numFullCopies * n + lenForRemainingTarget;
        }
        // If lenForRemainingTarget is Infinity, minLen remains Infinity, indicating no solution.
    }

    return minLen === Infinity ? -1 : minLen;
};