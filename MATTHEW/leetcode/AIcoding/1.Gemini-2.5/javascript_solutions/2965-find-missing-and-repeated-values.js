var findErrorNums = function(nums) {
    const n = nums.length;

    let actualSum = 0;
    let actualSumSq = 0;

    for (const num of nums) {
        actualSum += num;
        actualSumSq += num * num;
    }

    const expectedSum = n * (n + 1) / 2;
    const expectedSumSq = n * (n + 1) * (2 * n + 1) / 6;

    const diffSum = actualSum - expectedSum;
    const diffSumSq = actualSumSq - expectedSumSq;

    const sumAB = diffSumSq / diffSum;

    const repeated = (diffSum + sumAB) / 2;
    const missing = (sumAB - diffSum) / 2;

    return [repeated, missing];
};