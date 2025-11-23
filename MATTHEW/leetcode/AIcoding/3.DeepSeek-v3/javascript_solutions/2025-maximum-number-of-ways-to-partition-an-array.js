var waysToPartition = function(nums, k) {
    const n = nums.length;
    const prefix = new Array(n).fill(0);
    prefix[0] = nums[0];
    for (let i = 1; i < n; i++) {
        prefix[i] = prefix[i - 1] + nums[i];
    }

    let total = prefix[n - 1];
    let res = 0;

    const leftMap = new Map();
    for (let i = 0; i < n - 1; i++) {
        const sumLeft = prefix[i];
        const sumRight = total - sumLeft;
        if (sumLeft === sumRight) {
            res++;
        }
        leftMap.set(sumLeft, (leftMap.get(sumLeft) || 0) + 1);
    }

    const rightMap = new Map();
    let max = res;

    for (let i = n - 1; i >= 0; i--) {
        const diff = k - nums[i];
        const newTotal = total + diff;
        if (newTotal % 2 === 0) {
            const half = newTotal / 2;
            const leftCount = leftMap.get(half) || 0;
            const rightCount = rightMap.get(half) || 0;
            max = Math.max(max, leftCount + rightCount);
        }

        if (i > 0) {
            const sumLeft = prefix[i - 1];
            leftMap.set(sumLeft, (leftMap.get(sumLeft) || 0) - 1);
            const sumRight = total - sumLeft;
            rightMap.set(sumRight, (rightMap.get(sumRight) || 0) + 1);
        }
    }

    return max;
};