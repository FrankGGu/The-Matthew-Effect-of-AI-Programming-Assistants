int longestUploadedPrefix(int* A, int ASize) {
    int maxLength = 0, count = 0;
    for (int i = 0; i < ASize; i++) {
        count += (A[i] > 0) ? 1 : -1;
        if (count < 0) break;
        if (count == 0) maxLength = i + 1;
    }
    return maxLength;
}