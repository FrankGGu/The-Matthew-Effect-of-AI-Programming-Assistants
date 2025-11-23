int maximumSize(int* A, int ASize) {
    int count[100001] = {0};
    int maxCount = 0;

    for (int i = 0; i < ASize; i++) {
        if (++count[A[i]] == 1) {
            maxCount++;
        }
    }

    return maxCount;
}