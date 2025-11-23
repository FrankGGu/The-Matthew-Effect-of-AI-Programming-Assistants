int minTime(int* time, int timeSize, int m) {
    int left = 0, right = 0;
    for (int i = 0; i < timeSize; i++) {
        right += time[i];
    }

    while (left < right) {
        int mid = left + (right - left) / 2;
        if (check(time, timeSize, m, mid)) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
}

bool check(int* time, int timeSize, int m, int T) {
    int cnt = 1;
    int sum = 0, maxVal = 0;
    for (int i = 0; i < timeSize; i++) {
        sum += time[i];
        if (time[i] > maxVal) {
            maxVal = time[i];
        }
        if (sum - maxVal > T) {
            cnt++;
            if (cnt > m) {
                return false;
            }
            sum = time[i];
            maxVal = time[i];
        }
    }
    return true;
}