int largestAltitude(int* gain, int gainSize) {
    int max = 0, current = 0;
    for (int i = 0; i < gainSize; i++) {
        current += gain[i];
        if (current > max) max = current;
    }
    return max;
}