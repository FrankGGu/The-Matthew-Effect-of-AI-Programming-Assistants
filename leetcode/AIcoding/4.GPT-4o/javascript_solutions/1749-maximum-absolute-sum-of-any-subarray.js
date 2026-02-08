var maxAbsoluteSum = function(nums) {
    let maxEndingHere = 0, minEndingHere = 0;
    let maxSum = 0, minSum = 0;

    for (let num of nums) {
        maxEndingHere = Math.max(num, maxEndingHere + num);
        minEndingHere = Math.min(num, minEndingHere + num);
        maxSum = Math.max(maxSum, maxEndingHere);
        minSum = Math.min(minSum, minEndingHere);
    }

    return Math.max(maxSum, -minSum);
};