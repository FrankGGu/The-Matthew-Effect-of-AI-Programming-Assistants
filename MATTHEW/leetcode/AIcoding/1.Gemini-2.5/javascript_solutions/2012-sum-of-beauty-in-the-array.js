var sumOfBeauties = function(nums) {
    const n = nums.length;
    if (n < 3) {
        return 0;
    }

    let totalBeauty = 0;

    // leftMax[i] stores the maximum value in nums[0...i]
    const leftMax = new Array(n);
    leftMax[0] = nums[0];
    for (let i = 1; i < n; i++) {
        leftMax[i] = Math.max(leftMax[i - 1], nums[i]);
    }

    // rightMin[i] stores the minimum value in nums[i...n-1]
    const rightMin = new Array(n);
    rightMin[n - 1] = nums[n - 1];
    for (let i = n - 2; i >= 0; i--) {
        rightMin[i] = Math.min(rightMin[i + 1], nums[i]);
    }

    // Iterate for i from 1 to n-2
    for (let i = 1; i <= n - 2; i++) {
        const localPeakCondition = nums[i - 1] < nums[i] && nums[i] < nums[i + 1];

        if (localPeakCondition) {
            // Check for beauty = 3 condition
            // nums[i] > max(nums[0]...nums[i-1]) is nums[i] > leftMax[i-1]
            // nums[i] < min(nums[i+1]...nums[n-1]) is nums[i] < rightMin[i+1]
            const globalPeakCondition = nums[i] > leftMax[i - 1] && nums[i] < rightMin[i + 1];

            if (globalPeakCondition) {
                totalBeauty += 3;
            } else {
                totalBeauty += 2;
            }
        } else {
            totalBeauty += 1;
        }
    }

    return totalBeauty;
};