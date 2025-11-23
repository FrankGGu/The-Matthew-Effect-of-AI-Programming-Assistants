var countBalls = function(lowLimit, highLimit) {
    const boxCounts = {};
    let maxCount = 0;

    for (let i = lowLimit; i <= highLimit; i++) {
        let num = i;
        let sum = 0;
        while (num > 0) {
            sum += num % 10;
            num = Math.floor(num / 10);
        }
        boxCounts[sum] = (boxCounts[sum] || 0) + 1;
        if (boxCounts[sum] > maxCount) {
            maxCount = boxCounts[sum];
        }
    }

    return maxCount;
};