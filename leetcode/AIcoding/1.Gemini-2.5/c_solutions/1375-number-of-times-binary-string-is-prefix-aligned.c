int numTimesAllBlue(int* flips, int flipsSize) {
    int count = 0;
    int max_reach = 0;
    for (int i = 0; i < flipsSize; i++) {
        if (flips[i] > max_reach) {
            max_reach = flips[i];
        }
        if (max_reach == i + 1) {
            count++;
        }
    }
    return count;
}