var minOperations = function(num1, num2) {
    let count = 0;
    while (num1 > 0 || num2 > 0) {
        const digit1 = num1 % 10;
        const digit2 = num2 % 10;
        count += Math.abs(digit1 - digit2);
        num1 = Math.floor(num1 / 10);
        num2 = Math.floor(num2 / 10);
    }
    return count;
};