int numTimesAllBlue(int* flips, int flipsSize) {
    int max = 0;
    int count = 0;
    for (int i = 0; i < flipsSize; i++) {
        if (flips[i] > max) {
            max = flips[i];
        }
        if (max == i + 1) {
            count++;
        }
    }
    return count;
}