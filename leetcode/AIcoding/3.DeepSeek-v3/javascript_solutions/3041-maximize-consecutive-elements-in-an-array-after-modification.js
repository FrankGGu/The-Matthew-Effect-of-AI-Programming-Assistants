var maxSelectedElements = function(nums) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    let dp = new Map();
    let max = 1;

    for (let i = 0; i < n; i++) {
        const num = nums[i];
        let current = 1;

        if (dp.has(num - 1)) {
            current = Math.max(current, dp.get(num - 1) + 1);
        }
        if (dp.has(num)) {
            current = Math.max(current, dp.get(num) + 1);
        }

        dp.set(num, current);
        max = Math.max(max, current);
    }

    return max;
};