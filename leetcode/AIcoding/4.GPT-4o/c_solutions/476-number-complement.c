int findComplement(int num) {
    int mask = 1, complement = 0;
    while (mask <= num) {
        mask <<= 1;
    }
    while (mask > 0) {
        complement <<= 1;
        if ((num & mask) == 0) {
            complement |= 1;
        }
        mask >>= 1;
    }
    return complement;
}