var minimumSum = function(nums) {
    const n = nums.length;
    let minSum = Infinity;

    const leftMin = new Array(n);
    leftMin[0] = Infinity;
    for (let i = 1; i < n; i++) {
        leftMin[i] = Math.min(leftMin[i - 1], nums[i - 1]);
    }

    const rightMin = new Array(n);
    rightMin[n - 1] = Infinity;
    for (let i = n - 2; i >= 0; i--) {
        rightMin[i] = Math.min(rightMin[i + 1], nums[i + 1]);
    }

    for (let j = 1; j < n - 1; j++) {
        if (nums[j] > leftMin[j] && nums[j] > rightMin[j]) {
            minSum = Math.min(minSum, leftMin[j] + nums[j] + rightMin[j]);
        }
    }

    return minSum === Infinity ? -1 : minSum;
};