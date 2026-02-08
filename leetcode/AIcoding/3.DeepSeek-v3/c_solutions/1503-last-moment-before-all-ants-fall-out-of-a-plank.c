int getLastMoment(int n, int* left, int leftSize, int* right, int rightSize) {
    int maxTime = 0;

    for (int i = 0; i < leftSize; i++) {
        if (left[i] > maxTime) {
            maxTime = left[i];
        }
    }

    for (int i = 0; i < rightSize; i++) {
        if (n - right[i] > maxTime) {
            maxTime = n - right[i];
        }
    }

    return maxTime;
}