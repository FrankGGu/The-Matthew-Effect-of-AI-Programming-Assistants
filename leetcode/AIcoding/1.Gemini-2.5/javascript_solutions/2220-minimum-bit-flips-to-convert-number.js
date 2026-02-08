var minBitFlips = function(start, goal) {
    let xorResult = start ^ goal;
    let flips = 0;
    while (xorResult > 0) {
        if (xorResult & 1) {
            flips++;
        }
        xorResult >>= 1;
    }
    return flips;
};