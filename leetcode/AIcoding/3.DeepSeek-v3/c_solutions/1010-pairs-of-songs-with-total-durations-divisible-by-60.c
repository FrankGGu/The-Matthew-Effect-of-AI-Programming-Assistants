int numPairsDivisibleBy60(int* time, int timeSize) {
    int count[60] = {0};
    int result = 0;

    for (int i = 0; i < timeSize; i++) {
        int remainder = time[i] % 60;
        int complement = (60 - remainder) % 60;
        result += count[complement];
        count[remainder]++;
    }

    return result;
}