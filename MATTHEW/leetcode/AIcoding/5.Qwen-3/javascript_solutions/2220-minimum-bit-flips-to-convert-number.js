function minBitFlips(start, goal) {
    let xor = start ^ goal;
    let count = 0;
    while (xor) {
        count += xor & 1;
        xor >>= 1;
    }
    return count;
}