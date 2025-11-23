var complexNumberMultiply = function(num1, num2) {
    const [real1, imag1] = num1.slice(0, -1).split('+').map(Number);
    const [real2, imag2] = num2.slice(0, -1).split('+').map(Number);

    const realPart = real1 * real2 - imag1 * imag2;
    const imagPart = real1 * imag2 + real2 * imag1;

    return `${realPart}+${imagPart}i`;
};