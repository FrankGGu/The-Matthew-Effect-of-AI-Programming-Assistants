function countBitChanges(start, target) {
    let xor = start ^ target;
    let count = 0;
    while (xor) {
        count += xor & 1;
        xor >>= 1;
    }
    return count;
}