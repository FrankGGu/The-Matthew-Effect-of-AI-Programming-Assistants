var brokenCalc = function(startValue, target) {
    let count = 0;
    while (target > startValue) {
        if (target % 2 === 0) {
            target /= 2;
        } else {
            target++;
        }
        count++;
    }
    return count + (startValue - target);
};