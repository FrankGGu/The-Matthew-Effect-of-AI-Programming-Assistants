var minimumAverage = function(nums) {
    nums.sort((a, b) => a - b);
    let minAvg = Infinity;
    const n = nums.length;
    for (let i = 0; i < Math.floor(n / 2); i++) {
        const avg = (nums[i] + nums[n - 1 - i]) / 2;
        if (avg < minAvg) {
            minAvg = avg;
        }
    }
    return minAvg;
};