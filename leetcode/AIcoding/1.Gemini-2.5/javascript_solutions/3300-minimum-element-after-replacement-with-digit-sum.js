var minimumSum = function(nums) {
    let minResult = Infinity;

    for (let i = 0; i < nums.length; i++) {
        let num = nums[i];

        let singleDigitSum;
        if (num === 0) {
            singleDigitSum = 0;
        } else {
            singleDigitSum = (num - 1) % 9 + 1;
        }

        minResult = Math.min(minResult, singleDigitSum);
    }

    return minResult;
};