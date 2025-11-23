int binaryGap(int n) {
    int maxGap = 0;
    int lastOneIndex = -1;
    int currentIndex = 0;

    while (n > 0) {
        if ((n & 1) == 1) {
            if (lastOneIndex != -1) {
                int currentGap = currentIndex - lastOneIndex;
                if (currentGap > maxGap) {
                    maxGap = currentGap;
                }
            }
            lastOneIndex = currentIndex;
        }
        n >>= 1;
        currentIndex++;
    }

    return maxGap;
}