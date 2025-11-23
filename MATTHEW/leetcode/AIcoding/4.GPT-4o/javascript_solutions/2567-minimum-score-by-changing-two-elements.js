var minimumScore = function(nums, k) {
    let min = Math.min(...nums);
    let max = Math.max(...nums);

    if (k >= max - min) return 0;

    let sorted = nums.slice().sort((a, b) => a - b);
    let n = sorted.length;

    let left = Math.max(0, sorted[0] + k);
    let right = Math.min(max, sorted[n - 1] - k);

    return Math.max(0, right - left);
};