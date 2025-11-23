function complexNumberMultiply(a, b) {
    const parse = (s) => {
        const [real, imag] = s.split('+').map(Number);
        return { real, imag };
    };

    const aObj = parse(a);
    const bObj = parse(b);

    const real = aObj.real * bObj.real - aObj.imag * bObj.imag;
    const imag = aObj.real * bObj.imag + aObj.imag * bObj.real;

    return `${real}+${imag}i`;
}