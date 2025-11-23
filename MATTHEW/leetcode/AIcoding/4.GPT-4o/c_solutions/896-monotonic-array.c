bool isMonotonic(int* A, int ASize) {
    if (ASize <= 1) return true;
    bool increasing = true, decreasing = true;

    for (int i = 1; i < ASize; i++) {
        if (A[i] > A[i - 1]) {
            decreasing = false;
        } else if (A[i] < A[i - 1]) {
            increasing = false;
        }
    }

    return increasing || decreasing;
}