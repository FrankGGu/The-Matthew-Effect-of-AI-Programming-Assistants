int paintWalls(int* A, int ASize, int K) {
    int max = 0;
    for (int i = 0; i < ASize; i++) {
        if (A[i] > max) {
            max = A[i];
        }
    }

    int left = 1, right = max * ASize;
    while (left < right) {
        int mid = left + (right - left) / 2;
        int sum = 0, count = 0;
        for (int i = 0; i < ASize; i++) {
            if (sum + A[i] > mid) {
                count++;
                sum = A[i];
                if (sum > mid) break;
            } else {
                sum += A[i];
            }
        }
        if (sum > 0) count++;

        if (count <= K) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
}