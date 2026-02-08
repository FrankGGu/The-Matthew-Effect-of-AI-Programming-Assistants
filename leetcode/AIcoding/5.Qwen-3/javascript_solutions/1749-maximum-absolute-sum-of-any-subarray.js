function maxAbsoluteSum(nums) {
    let maxEndingHere = 0;
    let minEndingHere = 0;
    let maxAbsSum = 0;

    for (const num of nums) {
        maxEndingHere = Math.max(num, maxEndingHere + num);
        minEndingHere = Math.min(num, minEndingHere + num);
        maxAbsSum = Math.max(maxAbsSum, Math.abs(maxEndingHere), Math.abs(minEndingHere));
    }

    return maxAbsSum;
}