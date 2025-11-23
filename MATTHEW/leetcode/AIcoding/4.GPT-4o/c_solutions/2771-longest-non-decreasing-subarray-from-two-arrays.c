int longestNonDecreasingLength(int* A, int ASize, int* B, int BSize) {
    int maxLength = 0;
    int lengthA = 1, lengthB = 1;

    for (int i = 0; i < ASize; i++) {
        if (i > 0) {
            if (A[i] >= A[i - 1]) lengthA++;
            else lengthA = 1;

            if (B[i] >= B[i - 1]) lengthB++;
            else lengthB = 1;
        }
        if (i > 0) {
            if (A[i] >= B[i - 1]) lengthA++;
            else lengthA = 1;

            if (B[i] >= A[i - 1]) lengthB++;
            else lengthB = 1;
        }
        maxLength = maxLength > lengthA ? maxLength : lengthA;
        maxLength = maxLength > lengthB ? maxLength : lengthB;
    }

    return maxLength;
}