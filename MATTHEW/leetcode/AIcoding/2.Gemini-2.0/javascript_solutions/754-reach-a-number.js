var reachNumber = function(target) {
    target = Math.abs(target);
    let sum = 0;
    let steps = 0;
    while (sum < target) {
        steps++;
        sum += steps;
    }
    if ((sum - target) % 2 === 0) {
        return steps;
    } else {
        if (steps % 2 === 0) {
            return steps + 1;
        } else {
            return steps + 2;
        }
    }
};