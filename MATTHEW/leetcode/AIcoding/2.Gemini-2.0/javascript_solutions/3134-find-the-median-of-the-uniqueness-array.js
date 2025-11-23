var findMedian = function(nums) {
    const count = {};
    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }

    const uniqueNums = Object.keys(count).map(Number).sort((a, b) => a - b);
    const n = uniqueNums.length;

    if (n % 2 === 0) {
        return (uniqueNums[n / 2 - 1] + uniqueNums[n / 2]) / 2;
    } else {
        return uniqueNums[Math.floor(n / 2)];
    }
};