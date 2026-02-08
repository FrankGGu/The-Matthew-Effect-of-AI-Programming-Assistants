int captureForts(int* forts, int fortsSize) {
    int maxCapture = 0;
    int prev = -1;

    for (int i = 0; i < fortsSize; i++) {
        if (forts[i] != 0) {
            if (prev != -1 && forts[prev] != forts[i]) {
                maxCapture = (i - prev - 1) > maxCapture ? (i - prev - 1) : maxCapture;
            }
            prev = i;
        }
    }

    return maxCapture;
}