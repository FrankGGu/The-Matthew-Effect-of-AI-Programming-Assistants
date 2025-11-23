var minSubsequence = function(nums) {
    nums.sort((a, b) => b - a);
    let totalSum = nums.reduce((a, b) => a + b, 0);
    let subsequenceSum = 0;
    const result = [];

    for (let num of nums) {
        subsequenceSum += num;
        result.push(num);
        if (subsequenceSum > totalSum - subsequenceSum) {
            break;
        }
    }

    return result;
};