int getLastMoment(int n, int left[], int leftSize, int right[], int rightSize) {
    int maxLeft = 0, maxRight = 0;
    for (int i = 0; i < leftSize; i++) {
        if (left[i] > maxLeft) {
            maxLeft = left[i];
        }
    }
    for (int i = 0; i < rightSize; i++) {
        if (right[i] < n) {
            maxRight = n - right[i];
        }
    }
    return maxLeft > maxRight ? maxLeft : maxRight;
}