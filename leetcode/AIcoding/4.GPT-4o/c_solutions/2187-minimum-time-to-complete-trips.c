int minimumTime(int* time, int timeSize, int totalTrips) {
    long long left = 1, right = (long long)timeSize * (long long)totalTrips * 1000000000;
    while (left < right) {
        long long mid = left + (right - left) / 2;
        long long trips = 0;
        for (int i = 0; i < timeSize; i++) {
            trips += mid / time[i];
            if (trips >= totalTrips) break;
        }
        if (trips >= totalTrips) right = mid;
        else left = mid + 1;
    }
    return (int)left;
}