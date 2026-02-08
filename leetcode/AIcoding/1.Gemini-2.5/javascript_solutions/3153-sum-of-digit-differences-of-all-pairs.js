var sumDigitDifferences = function(nums) {
    let totalSumOfDifferences = 0;

    while (true) {
        let digitCounts = new Array(10).fill(0);
        let nextNums = new Array(nums.length);
        let hasRemainingDigits = false;

        for (let i = 0; i < nums.length; i++) {
            const num = nums[i];
            const digit = num % 10;
            digitCounts[digit]++;
            nextNums[i] = Math.floor(num / 10);
            if (nextNums[i] > 0) {
                hasRemainingDigits = true;
            }
        }

        let currentPositionSum = 0;
        for (let d1 = 0; d1 < 10; d1++) {
            for (let d2 = d1 + 1; d2 < 10; d2++) {
                currentPositionSum += digitCounts[d1] * digitCounts[d2] * (d2 - d1);
            }
        }
        totalSumOfDifferences += currentPositionSum;

        nums = nextNums;

        if (!hasRemainingDigits) {
            break;
        }
    }

    return totalSumOfDifferences;
};