int hammingDistance(int x, int y) {
    int xor = x ^ y;
    int distance = 0;
    while (xor) {
        distance += xor & 1;
        xor >>= 1;
    }
    return distance;
}