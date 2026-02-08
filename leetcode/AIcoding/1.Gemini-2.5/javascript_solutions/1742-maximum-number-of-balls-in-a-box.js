var countBalls = function(lowLimit, highLimit) {
    const boxCounts = new Array(46).fill(0);

    const getSumOfDigits = (num) => {
        let sum = 0;
        let temp = num;
        while (temp > 0) {
            sum += temp % 10;
            temp = Math.floor(temp / 10);
        }
        return sum;
    };

    for (let i = lowLimit; i <= highLimit; i++) {
        const boxNumber = getSumOfDigits(i);
        boxCounts[boxNumber]++;
    }

    let maxBalls = 0;
    for (let i = 0; i < boxCounts.length; i++) {
        if (boxCounts[i] > maxBalls) {
            maxBalls = boxCounts[i];
        }
    }

    return maxBalls;
};