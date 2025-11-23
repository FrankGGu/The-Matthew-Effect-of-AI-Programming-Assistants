function brokenCalc(target, startValue) {
    let steps = 0;
    while (startValue < target) {
        if (target % 2 === 1) {
            target++;
        } else {
            target /= 2;
        }
        steps++;
    }
    return steps + (startValue - target);
}