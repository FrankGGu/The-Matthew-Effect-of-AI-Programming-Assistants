var minimumSum = function(num) {
    const digits = String(num).split('').map(Number).sort();
    return (digits[0] * 10 + digits[2]) + (digits[1] * 10 + digits[3]);
};