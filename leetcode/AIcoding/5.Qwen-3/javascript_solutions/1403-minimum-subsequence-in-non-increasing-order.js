function minSubsequence(nums) {
    nums.sort((a, b) => b - a);
    let sum = nums.reduce((total, num) => total + num, 0);
    let currentSum = 0;
    let result = [];
    for (let num of nums) {
        currentSum += num;
        result.push(num);
        if (currentSum > sum - currentSum) {
            break;
        }
    }
    return result;
}