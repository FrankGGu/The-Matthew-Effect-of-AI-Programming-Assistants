int numPairsDivisibleBy60(int* time, int timeSize) {
    int count[60] = {0};
    int pairs = 0;

    for (int i = 0; i < timeSize; i++) {
        int remainder = time[i] % 60;
        pairs += count[(60 - remainder) % 60];
        count[remainder]++;
    }

    return pairs;
}