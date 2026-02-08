int changingKeys(int* keys, int keysSize) {
    int count = 0;
    for (int i = 0; i < keysSize; i++) {
        if (keys[i] != i + 1) {
            count++;
        }
    }
    return count;
}