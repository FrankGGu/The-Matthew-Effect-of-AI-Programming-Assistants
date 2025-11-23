var hasTrailingZeros = function(num1, num2) {
    return ((num1 | num2) & 1) === 0;
};