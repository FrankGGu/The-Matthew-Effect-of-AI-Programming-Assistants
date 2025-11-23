int constructTheMinimumBitwiseArray(int k) {
    k |= k >> 1;
    k |= k >> 2;
    k |= k >> 4;
    k |= k >> 8;
    k |= k >> 16;

    return (k + 1) >> 1;
}