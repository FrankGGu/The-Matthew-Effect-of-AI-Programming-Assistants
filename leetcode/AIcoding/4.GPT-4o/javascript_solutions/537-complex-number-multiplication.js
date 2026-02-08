function complexNumberMultiply(a, b) {
    const [realA, imagA] = a.split('+').map(x => parseInt(x));
    const [realB, imagB] = b.split('+').map(x => parseInt(x));
    const realPart = realA * realB - imagA * imagB;
    const imagPart = realA * imagB + imagA * realB;
    return `${realPart}+${imagPart}i`;
}