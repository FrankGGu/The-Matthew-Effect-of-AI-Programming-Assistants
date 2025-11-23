int numPairsDivisibleBy60(int* time, int timeSize) {
    int count = 0;
    int remainder[60] = {0};

    for (int i = 0; i < timeSize; i++) {
        int r = time[i] % 60;
        count += remainder[(60 - r) % 60];
        remainder[r]++;
    }

    return count;
}