int minSpeedOnTime(int* dist, int distSize, double hour) {
    int left = 1, right = 1e7, result = -1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        double time = 0.0;

        for (int i = 0; i < distSize; i++) {
            time += (i == distSize - 1) ? (double)dist[i] / mid : (dist[i] + mid - 1) / mid;
        }

        if (time <= hour) {
            result = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return result;
}