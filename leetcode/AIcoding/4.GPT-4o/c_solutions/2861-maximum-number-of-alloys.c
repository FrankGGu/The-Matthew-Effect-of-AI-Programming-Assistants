int maxAlloys(int* A, int ASize, int* B, int BSize) {
    int maxAlloys = 0;
    for (int i = 0; i < ASize; i++) {
        for (int j = 0; j < BSize; j++) {
            int alloys = A[i] < B[j] ? A[i] : B[j];
            if (alloys > maxAlloys) {
                maxAlloys = alloys;
            }
        }
    }
    return maxAlloys;
}