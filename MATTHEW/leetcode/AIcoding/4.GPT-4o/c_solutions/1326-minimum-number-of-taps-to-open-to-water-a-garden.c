int minTaps(int n, int* ranges, int rangesSize) {
    int maxReach[n + 1];
    for (int i = 0; i <= n; i++) {
        maxReach[i] = -1;
    }

    for (int i = 0; i < rangesSize; i++) {
        int left = i - ranges[i];
        int right = i + ranges[i];
        if (left < 0) left = 0;
        if (right > n) right = n;
        if (maxReach[left] < right) {
            maxReach[left] = right;
        }
    }

    int taps = 0, currEnd = 0, farthest = 0;
    for (int i = 0; i < n; i++) {
        if (i > farthest) return -1;
        if (i > currEnd) {
            taps++;
            currEnd = farthest;
        }
        if (maxReach[i] > farthest) {
            farthest = maxReach[i];
        }
    }

    return taps;
}