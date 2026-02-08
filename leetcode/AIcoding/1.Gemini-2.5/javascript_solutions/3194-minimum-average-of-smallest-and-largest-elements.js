var minimumAverage = function(nums) {
    nums.sort((a, b) => a - b);

    let minAvg = Infinity;
    const n = nums.length;

    for (let i = 0; i < n / 2; i++) {
        const currentAvg = (nums[i] + nums[n - 1 - i]) / 2;
        if (currentAvg < minAvg) {
            minAvg = currentAvg;
        }
    }

    return minAvg;
};