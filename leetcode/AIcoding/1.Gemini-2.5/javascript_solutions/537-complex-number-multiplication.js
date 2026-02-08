var complexNumberMultiply = function(num1, num2) {
    const parseComplex = (numStr) => {
        const parts = numStr.split('+');
        const real = parseInt(parts[0]);
        const imag = parseInt(parts[1].slice(0, -1));
        return [real, imag];
    };

    const [a, b] = parseComplex(num1);
    const [c, d] = parseComplex(num2);

    const realResult = (a * c) - (b * d);
    const imagResult = (a * d) + (b * c);

    return `${realResult}+${imagResult}i`;
};