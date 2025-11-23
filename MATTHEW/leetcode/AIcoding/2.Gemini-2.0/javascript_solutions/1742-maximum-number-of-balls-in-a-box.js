var countBalls = function(lowLimit, highLimit) {
    const boxes = {};
    let maxBalls = 0;

    for (let i = lowLimit; i <= highLimit; i++) {
        let sum = 0;
        let num = i;
        while (num > 0) {
            sum += num % 10;
            num = Math.floor(num / 10);
        }

        if (boxes[sum] === undefined) {
            boxes[sum] = 0;
        }
        boxes[sum]++;

        maxBalls = Math.max(maxBalls, boxes[sum]);
    }

    return maxBalls;
};