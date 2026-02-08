int countBits(int a, int b) {
    int diff = a ^ b;
    int count = 0;

    while (diff) {
        count += diff & 1;
        diff >>= 1;
    }

    return count;
}