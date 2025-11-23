var findXValue = function(nums, n) {
    let x = nums[0];
    for (let i = 1; i < n; i++) {
        x = x ^ nums[i];
    }
    return x;
};