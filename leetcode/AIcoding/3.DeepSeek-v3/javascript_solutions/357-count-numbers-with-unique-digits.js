var countNumbersWithUniqueDigits = function(n) {
    if (n === 0) return 1;
    let res = 10;
    let uniqueDigits = 9;
    let availableNumbers = 9;
    for (let i = 2; i <= n; i++) {
        if (availableNumbers === 0) {
            res += 0;
            continue;
        }
        uniqueDigits = uniqueDigits * availableNumbers;
        res += uniqueDigits;
        availableNumbers--;
    }
    return res;
};