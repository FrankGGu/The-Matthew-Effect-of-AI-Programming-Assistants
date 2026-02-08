var minFlips = function(a, b, c) {
    let flips = 0;
    for (let i = 0; i < 32; i++) {
        const aBit = (a >> i) & 1;
        const bBit = (b >> i) & 1;
        const cBit = (c >> i) & 1;

        if ((aBit | bBit) !== cBit) {
            if (cBit === 0) {
                if (aBit === 1 && bBit === 1) {
                    flips += 2;
                } else {
                    flips += 1;
                }
            } else {
                flips += 1;
            }
        }
    }
    return flips;
};