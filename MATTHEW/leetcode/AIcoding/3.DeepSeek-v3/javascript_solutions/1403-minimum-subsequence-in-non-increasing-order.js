var minSubsequence = function(nums) {
    nums.sort((a, b) => b - a);
    const totalSum = nums.reduce((sum, num) => sum + num, 0);
    let currentSum = 0;
    const result = [];

    for (let num of nums) {
        currentSum += num;
        result.push(num);
        if (currentSum > totalSum - currentSum) {
            break;
        }
    }

    return result;
};