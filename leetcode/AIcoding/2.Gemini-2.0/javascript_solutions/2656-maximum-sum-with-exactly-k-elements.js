var maximizeSum = function(nums, k) {
    let maxNum = Math.max(...nums);
    return maxNum * k + (k * (k - 1)) / 2;
};