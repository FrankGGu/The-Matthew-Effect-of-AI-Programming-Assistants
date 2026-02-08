int largestCombination(int* candidates, int candidatesSize) {
    int maxCount = 0;
    for (int i = 0; i < 32; i++) {
        int count = 0;
        for (int j = 0; j < candidatesSize; j++) {
            if (candidates[j] & (1 << i)) {
                count++;
            }
        }
        if (count > maxCount) {
            maxCount = count;
        }
    }
    return maxCount;
}