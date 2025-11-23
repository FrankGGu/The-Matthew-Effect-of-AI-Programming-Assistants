var findMinimumArrayLength = function(nums) {
    let sum = 0;
    let maxVal = 0;
    for (let num of nums) {
        sum += num;
        maxVal = Math.max(maxVal, num);
    }

    if (maxVal > sum - maxVal) {
        return 2 * maxVal - sum;
    } else {
        return sum % 2;
    }
};