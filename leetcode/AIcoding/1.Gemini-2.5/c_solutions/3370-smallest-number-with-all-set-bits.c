unsigned int smallestNumberWithAllSetBits(int k) {
    if (k == 32) {
        return 0xFFFFFFFFU;
    }
    return (1U << k) - 1;
}