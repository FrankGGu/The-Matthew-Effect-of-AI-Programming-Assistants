double timeRequired(int* dist, int distSize, int speed) {
    double time = 0.0;
    for (int i = 0; i < distSize - 1; i++) {
        time += ceil((double)dist[i] / speed);
    }
    time += (double)dist[distSize - 1] / speed;
    return time;
}

int minSpeedOnTime(int* dist, int distSize, double hour) {
    if (distSize - 1 >= hour) return -1;

    int left = 1;
    int right = 1e7;
    int result = -1;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        double time = timeRequired(dist, distSize, mid);

        if (time <= hour) {
            result = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return result;
}