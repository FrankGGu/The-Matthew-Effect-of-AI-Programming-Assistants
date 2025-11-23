var countBalls = function(lowLimit, highLimit) {
    const boxCount = new Array(46).fill(0);
    let maxBalls = 0;

    for (let i = lowLimit; i <= highLimit; i++) {
        let sum = 0;
        let num = i;
        while (num > 0) {
            sum += num % 10;
            num = Math.floor(num / 10);
        }
        boxCount[sum]++;
        maxBalls = Math.max(maxBalls, boxCount[sum]);
    }

    return maxBalls;
};