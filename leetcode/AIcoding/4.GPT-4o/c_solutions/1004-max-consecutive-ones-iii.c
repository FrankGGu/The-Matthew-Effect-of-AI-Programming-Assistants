int longestOnes(int* A, int ASize, int K) {
    int left = 0, right = 0, maxLength = 0, zeroCount = 0;

    while (right < ASize) {
        if (A[right] == 0) {
            zeroCount++;
        }

        while (zeroCount > K) {
            if (A[left] == 0) {
                zeroCount--;
            }
            left++;
        }

        maxLength = fmax(maxLength, right - left + 1);
        right++;
    }

    return maxLength;
}