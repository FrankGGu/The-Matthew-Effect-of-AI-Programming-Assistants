var minimumCost = function(nums) {
    const n = nums.length;
    let minSumOfSecondAndThird = Infinity;

    for (let s2 = 1; s2 <= n - 2; s2++) {
        for (let s3 = s2 + 1; s3 <= n - 1; s3++) {
            minSumOfSecondAndThird = Math.min(minSumOfSecondAndThird, nums[s2] + nums[s3]);
        }
    }

    return nums[0] + minSumOfSecondAndThird;
};