var numSteps = function(s) {
    let num = BigInt("0b" + s);
    let steps = 0;
    while (num > 1n) {
        if (num % 2n === 0n) {
            num /= 2n;
        } else {
            num += 1n;
        }
        steps++;
    }
    return steps;
};