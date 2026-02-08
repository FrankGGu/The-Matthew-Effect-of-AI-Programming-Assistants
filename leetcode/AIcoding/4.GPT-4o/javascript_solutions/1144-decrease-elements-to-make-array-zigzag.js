var movesToMakeZigzag = function(nums) {
    let n = nums.length;
    let cost1 = 0, cost2 = 0;

    for (let i = 0; i < n; i++) {
        let left = (i > 0) ? nums[i - 1] : Infinity;
        let right = (i < n - 1) ? nums[i + 1] : Infinity;
        let minNeighbor = Math.min(left, right);
        if (nums[i] >= minNeighbor) {
            if (i % 2 === 0) {
                cost1 += nums[i] - minNeighbor + 1;
            } else {
                cost2 += nums[i] - minNeighbor + 1;
            }
        }
    }

    return Math.min(cost1, cost2);
};