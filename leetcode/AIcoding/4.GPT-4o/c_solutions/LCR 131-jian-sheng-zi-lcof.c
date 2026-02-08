int cutWood(int* A, int ASize, int target) {
    int left = 1, right = 0;
    for (int i = 0; i < ASize; i++) {
        if (A[i] > right) {
            right = A[i];
        }
    }

    while (left < right) {
        int mid = left + (right - left) / 2;
        long long sum = 0;
        for (int i = 0; i < ASize; i++) {
            if (A[i] > mid) {
                sum += A[i] - mid;
            }
        }
        if (sum < target) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left - 1;
}