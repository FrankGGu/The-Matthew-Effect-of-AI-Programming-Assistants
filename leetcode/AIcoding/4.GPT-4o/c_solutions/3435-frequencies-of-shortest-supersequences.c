int shortestSupersequence(char **A, int ASize, char **B, int BSize) {
    int freq[10001] = {0};
    int count = 0, minLength = INT_MAX, start = 0;
    int left = 0, right = 0;
    int total = 0;
    int required[10001] = {0};

    for (int i = 0; i < BSize; i++) {
        required[B[i][0]]++;
    }

    while (right < ASize) {
        if (required[A[right][0]] > 0) {
            freq[A[right][0]]++;
            if (freq[A[right][0]] <= required[A[right][0]]) {
                count++;
            }
        }

        while (count == BSize) {
            if (right - left + 1 < minLength) {
                minLength = right - left + 1;
                start = left;
            }
            if (required[A[left][0]] > 0) {
                freq[A[left][0]]--;
                if (freq[A[left][0]] < required[A[left][0]]) {
                    count--;
                }
            }
            left++;
        }
        right++;
    }

    return minLength == INT_MAX ? 0 : minLength;
}