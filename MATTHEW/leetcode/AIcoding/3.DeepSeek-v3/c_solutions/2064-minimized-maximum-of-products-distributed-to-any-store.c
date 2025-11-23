int minimizedMaximum(int n, int* quantities, int quantitiesSize) {
    int left = 1, right = 0;
    for (int i = 0; i < quantitiesSize; i++) {
        if (quantities[i] > right) {
            right = quantities[i];
        }
    }

    while (left < right) {
        int mid = left + (right - left) / 2;
        int stores = 0;

        for (int i = 0; i < quantitiesSize; i++) {
            stores += (quantities[i] + mid - 1) / mid;
        }

        if (stores > n) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
}