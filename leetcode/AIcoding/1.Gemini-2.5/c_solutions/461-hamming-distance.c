int hammingDistance(int x, int y) {
    int xor_result = x ^ y;
    int count = 0;
    while (xor_result > 0) {
        xor_result &= (xor_result - 1);
        count++;
    }
    return count;
}