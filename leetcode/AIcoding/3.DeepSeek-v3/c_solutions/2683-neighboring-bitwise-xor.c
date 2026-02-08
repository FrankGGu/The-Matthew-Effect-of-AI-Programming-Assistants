int doesValidArrayExist(int* derived, int derivedSize) {
    int xor_sum = 0;
    for (int i = 0; i < derivedSize; i++) {
        xor_sum ^= derived[i];
    }
    return xor_sum == 0;
}