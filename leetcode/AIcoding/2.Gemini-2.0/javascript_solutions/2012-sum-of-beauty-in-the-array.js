var sumOfBeauty = function(nums) {
    const n = nums.length;
    let beautySum = 0;
    const leftMax = new Array(n).fill(0);
    const rightMin = new Array(n).fill(0);

    leftMax[0] = nums[0];
    for (let i = 1; i < n; i++) {
        leftMax[i] = Math.max(leftMax[i - 1], nums[i]);
    }

    rightMin[n - 1] = nums[n - 1];
    for (let i = n - 2; i >= 0; i--) {
        rightMin[i] = Math.min(rightMin[i + 1], nums[i]);
    }

    for (let i = 1; i < n - 1; i++) {
        if (nums[i] > leftMax[i - 1] && nums[i] < rightMin[i + 1]) {
            beautySum += 2;
        } else if (nums[i] > nums[i - 1] && nums[i] < nums[i + 1]) {
            beautySum += 1;
        }
    }

    return beautySum;
};