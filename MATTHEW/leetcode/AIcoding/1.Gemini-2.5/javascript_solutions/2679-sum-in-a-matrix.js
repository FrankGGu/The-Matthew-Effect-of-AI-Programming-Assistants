var sumInMatrix = function(nums) {
    const m = nums.length;
    const n = nums[0].length;

    for (let i = 0; i < m; i++) {
        nums[i].sort((a, b) => a - b);
    }

    let totalSum = 0;

    for (let j = 0; j < n; j++) {
        let currentMax = 0;
        for (let i = 0; i < m; i++) {
            currentMax = Math.max(currentMax, nums[i].pop());
        }
        totalSum += currentMax;
    }

    return totalSum;
};