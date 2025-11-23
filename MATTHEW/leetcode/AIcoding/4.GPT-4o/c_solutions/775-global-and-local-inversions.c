bool isIdealPermutation(int* A, int ASize) {
    for (int i = 0; i < ASize; i++) {
        if (abs(A[i] - i) > 1) {
            return false;
        }
    }
    return true;
}