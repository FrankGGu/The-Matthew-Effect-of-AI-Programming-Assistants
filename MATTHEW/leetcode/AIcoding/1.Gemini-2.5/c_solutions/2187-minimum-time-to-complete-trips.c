long long canComplete(long long time, int* tripTimes, int tripTimesSize, int totalTrips) {
    long long completedTrips = 0;
    for (int i = 0; i < tripTimesSize; i++) {
        completedTrips += time / tripTimes[i];
        if (completedTrips >= totalTrips) {
            return 1;
        }
    }
    return completedTrips >= totalTrips;
}

long long minimumTime(int* tripTimes, int tripTimesSize, int totalTrips) {
    long long low = 1;
    long long high = (long long)1e14; 
    long long ans = high;

    while (low <= high) {
        long long mid = low + (high - low) / 2;
        if (canComplete(mid, tripTimes, tripTimesSize, totalTrips)) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}