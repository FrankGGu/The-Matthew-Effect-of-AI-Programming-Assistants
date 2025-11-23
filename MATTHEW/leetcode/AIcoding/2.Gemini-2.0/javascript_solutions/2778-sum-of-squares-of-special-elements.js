var sumOfSquares = function(nums) {
    let n = nums.length;
    let sum = 0;
    for (let i = 0; i < n; i++) {
        if ((i + 1) % 1 === 0 && n % (i + 1) === 0) {
            sum += nums[i] * nums[i];
        }
    }
    return sum;
};