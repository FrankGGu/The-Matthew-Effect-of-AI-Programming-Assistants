var getSumAbsoluteDifferences = function(nums) {
    const n = nums.length;
    const result = new Array(n);
    let prefixSum = 0;
    let totalSum = nums.reduce((sum, num) => sum + num, 0);

    for (let i = 0; i < n; i++) {
        result[i] = nums[i] * i - prefixSum + (totalSum - prefixSum - nums[i] * (n - i));
        prefixSum += nums[i];
    }

    return result;
};