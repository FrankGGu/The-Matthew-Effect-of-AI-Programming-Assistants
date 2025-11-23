var minFlips = function(a, b, c) {
    let flips = 0;
    for (let i = 0; i < 32; i++) {
        const aBit = (a >> i) & 1;
        const bBit = (b >> i) & 1;
        const cBit = (c >> i) & 1;
        const or = aBit | bBit;
        if (or !== cBit) {
            if (cBit === 1) {
                flips += 1;
            } else {
                flips += (aBit + bBit);
            }
        }
    }
    return flips;
};