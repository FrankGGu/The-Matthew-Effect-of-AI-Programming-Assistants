int numPairsDivisibleBy60(int* time, int timeSize) {
    int remainders[60] = {0};
    int count = 0;

    for (int i = 0; i < timeSize; i++) {
        int t = time[i];
        int r = t % 60;

        if (r == 0) {
            count += remainders[0];
        } else {
            count += remainders[60 - r];
        }

        remainders[r]++;
    }

    return count;
}