int binaryGap(int n) {
    int maxGap = 0;
    int lastPos = -1;
    int currentPos = 0;

    while (n > 0) {
        if (n & 1) {
            if (lastPos != -1) {
                int gap = currentPos - lastPos;
                if (gap > maxGap) {
                    maxGap = gap;
                }
            }
            lastPos = currentPos;
        }
        n >>= 1;
        currentPos++;
    }

    return maxGap;
}