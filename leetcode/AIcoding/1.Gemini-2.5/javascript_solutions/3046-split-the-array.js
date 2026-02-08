var splitArray = function(nums) {
    const n = nums.length;
    const half_n = n / 2;

    let sum1 = 0;
    for (let i = 0; i < half_n; i++) {
        sum1 += nums[i];
    }

    let sum2 = 0;
    for (let i = half_n; i < n; i++) {
        sum2 += nums[i];
    }

    return sum1 > sum2;
};