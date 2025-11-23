var findNthDigit = function(n) {
    let digits = 1;
    let count = 9;
    let base = 1;

    while (n > digits * count) {
        n -= digits * count;
        digits++;
        count *= 10;
        base *= 10;
    }

    // n is now the remaining count of digits within the current 'digits' group.
    // base is the first number in this 'digits' group (e.g., 1, 10, 100).

    // Calculate the number that contains the nth digit
    // (n - 1) because n is 1-indexed, and we want 0-indexed offset from base
    let num = base + Math.floor((n - 1) / digits);

    // Calculate the index of the digit within that number
    let indexInNum = (n - 1) % digits;

    // Convert the number to a string and extract the digit
    let numStr = String(num);
    return parseInt(numStr[indexInNum]);
};