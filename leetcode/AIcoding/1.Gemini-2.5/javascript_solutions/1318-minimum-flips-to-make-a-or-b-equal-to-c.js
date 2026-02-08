var minFlips = function(a, b, c) {
    let flips = 0;

    while (a > 0 || b > 0 || c > 0) {
        const bitA = a & 1;
        const bitB = b & 1;
        const bitC = c & 1;

        if (bitC === 0) {
            // If target bit is 0, both a and b's current bits must be 0.
            // Flip a's bit if it's 1.
            if (bitA === 1) {
                flips++;
            }
            // Flip b's bit if it's 1.
            if (bitB === 1) {
                flips++;
            }
        } else { // bitC === 1
            // If target bit is 1, at least one of a or b's current bits must be 1.
            // If both a and b's bits are 0, we need one flip.
            if (bitA === 0 && bitB === 0) {
                flips++;
            }
        }

        a >>= 1;
        b >>= 1;
        c >>= 1;
    }

    return flips;
};