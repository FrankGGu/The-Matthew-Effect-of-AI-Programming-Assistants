var minimumSum = function(num) {
    const digits = String(num).split('').sort();
    const num1 = parseInt(digits[0] + digits[2]);
    const num2 = parseInt(digits[1] + digits[3]);
    return num1 + num2;
};