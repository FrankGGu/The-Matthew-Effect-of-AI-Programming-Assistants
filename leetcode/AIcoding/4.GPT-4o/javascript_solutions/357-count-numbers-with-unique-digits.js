var countNumbersWithUniqueDigits = function(n) {
    if (n === 0) return 1;
    if (n === 1) return 10;

    let count = 10;
    let uniqueDigits = 9;
    let availableNumbers = 9;

    for (let i = 2; i <= n; i++) {
        uniqueDigits *= availableNumbers;
        count += uniqueDigits;
        availableNumbers--;
    }

    return count;
};