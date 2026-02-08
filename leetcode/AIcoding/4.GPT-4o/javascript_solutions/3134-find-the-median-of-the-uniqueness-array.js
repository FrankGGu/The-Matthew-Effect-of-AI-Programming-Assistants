function findMedian(nums) {
    const uniqueNums = [...new Set(nums)].sort((a, b) => a - b);
    const mid = Math.floor(uniqueNums.length / 2);
    return uniqueNums.length % 2 === 0 ? (uniqueNums[mid - 1] + uniqueNums[mid]) / 2 : uniqueNums[mid];
}