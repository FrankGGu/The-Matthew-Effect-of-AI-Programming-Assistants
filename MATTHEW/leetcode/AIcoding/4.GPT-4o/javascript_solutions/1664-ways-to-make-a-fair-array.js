var waysToMakeFair = function(nums) {
    const n = nums.length;
    let leftSumEven = 0, leftSumOdd = 0;
    let rightSumEven = 0, rightSumOdd = 0;
    let result = 0;

    for (let i = 0; i < n; i++) {
        if (i % 2 === 0) {
            rightSumEven += nums[i];
        } else {
            rightSumOdd += nums[i];
        }
    }

    for (let i = 0; i < n; i++) {
        if (i % 2 === 0) {
            rightSumEven -= nums[i];
        } else {
            rightSumOdd -= nums[i];
        }

        if (leftSumEven + rightSumOdd === leftSumOdd + rightSumEven) {
            result++;
        }

        if (i % 2 === 0) {
            leftSumEven += nums[i];
        } else {
            leftSumOdd += nums[i];
        }
    }

    return result;
};