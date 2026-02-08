var minMaxDifference = function(nums, k) {
    nums.sort((a, b) => a - b);
    let minAvg = Infinity;
    for (let i = 0; i <= nums.length - k; i++) {
        let smallest = nums[i];
        let largest = nums[i + k - 1];
        let avg = (smallest + largest) / 2;
        minAvg = Math.min(minAvg, avg);
    }
    return minAvg;
};