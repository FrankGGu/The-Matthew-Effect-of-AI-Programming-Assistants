int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int maximumTastiness(int* price, int priceSize, int k) {
    qsort(price, priceSize, sizeof(int), cmp);

    int left = 0;
    int right = price[priceSize - 1] - price[0];

    while (left < right) {
        int mid = left + (right - left + 1) / 2;
        int count = 1;
        int last = price[0];

        for (int i = 1; i < priceSize; i++) {
            if (price[i] - last >= mid) {
                count++;
                last = price[i];
            }
        }

        if (count >= k) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }

    return left;
}