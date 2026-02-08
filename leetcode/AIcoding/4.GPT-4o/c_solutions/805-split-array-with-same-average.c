bool canSplit(int* A, int n, int sumA, int lenA, int count, int sumB, int lenB) {
    if (count == 0) return lenA == 0 || lenB == 0 || sumA * lenB == sumB * lenA;
    for (int i = 0; i < n; i++) {
        if (A[i] == -1) continue;
        int num = A[i];
        A[i] = -1;
        if (canSplit(A, n, sumA + num, lenA + 1, count - 1, sumB, lenB) || 
            canSplit(A, n, sumA, lenA, count, sumB + num, lenB + 1)) {
            return true;
        }
        A[i] = num;
    }
    return false;
}

bool splitArraySameAverage(int* A, int ASize) {
    int sum = 0;
    for (int i = 0; i < ASize; i++) {
        sum += A[i];
    }
    for (int len = 1; len <= ASize / 2; len++) {
        if (sum * len % ASize == 0) {
            if (canSplit(A, ASize, 0, 0, len, 0, 0)) {
                return true;
            }
        }
    }
    return false;
}