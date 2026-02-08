var minimumSum = function(num) {
    const s = String(num);
    const digits = [];
    for (let i = 0; i < s.length; i++) {
        digits.push(parseInt(s[i]));
    }

    digits.sort((a, b) => a - b);

    const num1 = digits[0] * 10 + digits[2];
    const num2 = digits[1] * 10 + digits[3];

    return num1 + num2;
};