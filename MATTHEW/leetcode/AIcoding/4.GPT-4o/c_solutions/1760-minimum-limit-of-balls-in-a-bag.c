int minimumSize(int* A, int ASize, int maxOperations) {
    int left = 1, right = 0;
    for (int i = 0; i < ASize; i++) {
        if (A[i] > right) {
            right = A[i];
        }
    }

    while (left < right) {
        int mid = left + (right - left) / 2;
        int operations = 0;

        for (int i = 0; i < ASize; i++) {
            operations += (A[i] - 1) / mid;
        }

        if (operations > maxOperations) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
}