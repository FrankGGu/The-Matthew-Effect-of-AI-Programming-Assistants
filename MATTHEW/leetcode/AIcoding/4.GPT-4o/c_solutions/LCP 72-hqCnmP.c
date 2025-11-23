int maxCarryOn(int* A, int ASize) {
    int total = 0, maxCarry = 0;
    for (int i = 0; i < ASize; i++) {
        total += A[i];
        if (total < 0) {
            total = 0;
        }
        if (total > maxCarry) {
            maxCarry = total;
        }
    }
    return maxCarry;
}