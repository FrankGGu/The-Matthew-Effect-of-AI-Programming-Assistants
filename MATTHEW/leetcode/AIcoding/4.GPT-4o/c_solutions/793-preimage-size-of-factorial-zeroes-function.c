int preimageSizeFZF(int K) {
    long long low = 0, high = 5 * (K + 1), mid;

    while (low < high) {
        mid = (low + high) / 2;
        long long count = 0, num = mid;

        while (num > 0) {
            num /= 5;
            count += num;
        }

        if (count < K) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }

    low = high;
    long long count = 0, num = low;

    while (num > 0) {
        num /= 5;
        count += num;
    }

    return count == K ? 5 : 0;
}