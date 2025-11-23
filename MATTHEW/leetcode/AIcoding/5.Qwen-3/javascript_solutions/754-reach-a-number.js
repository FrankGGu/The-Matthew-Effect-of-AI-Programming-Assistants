function reachNumber(target) {
    let steps = 0;
    let sum = 0;
    target = Math.abs(target);
    while (sum < target || (sum - target) % 2 !== 0) {
        steps++;
        sum += steps;
    }
    return steps;
}