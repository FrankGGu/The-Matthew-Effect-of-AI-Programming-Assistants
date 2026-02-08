var myPow = function(x, n) {
    if (n === 0) {
        return 1.0;
    }

    let result = 1.0;
    let currentX = x;
    let power = n;

    if (power < 0) {
        currentX = 1 / currentX;
        power = -power;
    }

    while (power > 0) {
        if (power % 2 === 1) {
            result *= currentX;
        }
        currentX *= currentX;
        power = Math.floor(power / 2);
    }

    return result;
};