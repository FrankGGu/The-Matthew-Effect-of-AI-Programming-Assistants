function minArrayEnd(n, index) {
    let result = 0;
    let mask = 1;
    let i = 0;
    while (i < n - 1) {
        if ((index & mask) === 0) {
            result |= mask;
            i++;
        }
        mask <<= 1;
    }
    return result;
}