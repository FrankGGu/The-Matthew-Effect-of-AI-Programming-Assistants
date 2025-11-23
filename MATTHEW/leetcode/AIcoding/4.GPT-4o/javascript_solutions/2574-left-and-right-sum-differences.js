var leftRightDifference = function(nums) {
    let totalSum = nums.reduce((a, b) => a + b, 0);
    let leftSum = 0;
    return nums.map(num => {
        let rightSum = totalSum - leftSum - num;
        let diff = Math.abs(leftSum - rightSum);
        leftSum += num;
        return diff;
    });
};