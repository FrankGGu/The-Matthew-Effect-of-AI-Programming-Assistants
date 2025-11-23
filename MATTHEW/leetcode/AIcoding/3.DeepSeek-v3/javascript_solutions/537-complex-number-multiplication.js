var complexNumberMultiply = function(num1, num2) {
    const parseComplex = (num) => {
        const parts = num.split('+');
        const real = parseInt(parts[0]);
        const imaginary = parseInt(parts[1]);
        return { real, imaginary };
    };

    const a = parseComplex(num1);
    const b = parseComplex(num2);

    const realPart = a.real * b.real - a.imaginary * b.imaginary;
    const imaginaryPart = a.real * b.imaginary + a.imaginary * b.real;

    return `${realPart}+${imaginaryPart}i`;
};