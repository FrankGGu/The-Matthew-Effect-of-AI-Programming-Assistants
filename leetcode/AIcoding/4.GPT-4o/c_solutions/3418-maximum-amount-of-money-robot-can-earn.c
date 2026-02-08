int maxProfit(int* A, int ASize) {
    if (ASize == 0) return 0;
    int rob1 = 0, rob2 = 0;
    for (int i = 0; i < ASize; i++) {
        int temp = rob2;
        rob2 = fmax(rob1 + A[i], rob2);
        rob1 = temp;
    }
    return rob2;
}