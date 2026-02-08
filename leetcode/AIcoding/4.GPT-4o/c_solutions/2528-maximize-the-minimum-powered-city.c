int maxPower(int* A, int ASize, int k) {
    int left = 1, right = 1e9, ans = 0;

    while (left <= right) {
        int mid = left + (right - left) / 2, sum = 0;
        for (int i = 0; i < ASize; i++) {
            sum += (A[i] < mid) ? mid - A[i] : 0;
        }

        if (sum <= k) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return ans;
}