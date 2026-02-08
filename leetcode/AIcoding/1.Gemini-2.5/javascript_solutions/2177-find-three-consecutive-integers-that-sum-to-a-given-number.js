var sumOfThree = function(num) {
    if (num % 3 !== 0) {
        return [];
    }

    const x = num / 3 - 1;
    return [x, x + 1, x + 2];
};