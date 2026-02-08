function minFlips(a, b, c) {
    let count = 0;
    for (let i = 0; i < 32; i++) {
        const bitA = (a >> i) & 1;
        const bitB = (b >> i) & 1;
        const bitC = (c >> i) & 1;
        if (bitC === 0) {
            count += bitA + bitB;
        } else {
            count += (bitA ^ bitB);
        }
    }
    return count;
}