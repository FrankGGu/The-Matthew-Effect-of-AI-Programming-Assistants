var sumOfTheDigitsOfHarshadNumber = function(x) {
    if (x <= 0) return -1;
    const original = x;
    let sum = 0;
    while (x > 0) {
        sum += x % 10;
        x = Math.floor(x / 10);
    }
    return original % sum === 0 ? sum : -1;
};