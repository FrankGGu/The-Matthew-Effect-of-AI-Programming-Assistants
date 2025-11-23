function minimumAverage(nums) {
    nums.sort((a, b) => a - b);
    let n = nums.length;
    let minAvg = Infinity;
    for (let i = 0; i < n / 2; i++) {
        let avg = (nums[i] + nums[n - 1 - i]) / 2;
        if (avg < minAvg) {
            minAvg = avg;
        }
    }
    return minAvg;
}