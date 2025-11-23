function minFlips(a, b, c) {
    let flips = 0;
    while (a > 0 || b > 0 || c > 0) {
        const bitA = a & 1;
        const bitB = b & 1;
        const bitC = c & 1;
        if ((bitA | bitB) !== bitC) {
            if (bitC === 1) {
                flips += 1;
            } else {
                flips += (bitA + bitB);
            }
        }
        a >>= 1;
        b >>= 1;
        c >>= 1;
    }
    return flips;
}