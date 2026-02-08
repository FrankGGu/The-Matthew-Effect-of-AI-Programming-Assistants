long long maxPower(int* stations, int stationsSize, int r, int k) {
    long long left = 0, right = 0;
    for (int i = 0; i < stationsSize; i++) {
        right += stations[i];
    }
    right += k;

    long long* power = (long long*)malloc(stationsSize * sizeof(long long));
    long long* diff = (long long*)malloc((stationsSize + 1) * sizeof(long long));

    while (left < right) {
        long long mid = right - (right - left) / 2;

        for (int i = 0; i <= stationsSize; i++) {
            diff[i] = 0;
        }

        long long curr = 0, need = 0;
        for (int i = 0; i < stationsSize; i++) {
            curr += diff[i];
            long long total = stations[i] + curr;
            if (total < mid) {
                long long add = mid - total;
                need += add;
                if (need > k) break;
                curr += add;
                if (i + 2 * r + 1 <= stationsSize) {
                    diff[i + 2 * r + 1] -= add;
                }
            }
        }

        if (need <= k) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }

    free(power);
    free(diff);
    return left;
}