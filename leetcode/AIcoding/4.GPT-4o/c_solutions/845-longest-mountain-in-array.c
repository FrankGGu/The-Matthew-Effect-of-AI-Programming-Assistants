int longestMountain(int* A, int ASize) {
    int max_length = 0;

    for (int i = 1; i < ASize - 1; i++) {
        if (A[i] > A[i - 1] && A[i] > A[i + 1]) {
            int left = i, right = i;
            while (left > 0 && A[left - 1] < A[left]) left--;
            while (right < ASize - 1 && A[right + 1] < A[right]) right++;
            max_length = max_length > (right - left + 1) ? max_length : (right - left + 1);
        }
    }

    return max_length;
}