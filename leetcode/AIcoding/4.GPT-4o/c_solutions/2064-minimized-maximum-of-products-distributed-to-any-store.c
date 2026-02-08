int minimizedMaximum(int n, int[] quantities, int quantitiesSize) {
    int left = 1, right = 1e9, mid, total;

    while (left < right) {
        mid = left + (right - left) / 2;
        total = 0;
        for (int i = 0; i < quantitiesSize; i++) {
            total += (quantities[i] + mid - 1) / mid;
        }
        if (total > n) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
}