#define MOD 1000000007

int cmp(const void *a, const void *b) {
    return ((int*)b)[1] - ((int*)a)[1];
}

int maxPerformance(int n, int speed[], int efficiency[], int k) {
    long totalSpeed = 0, maxPerformance = 0;
    int team[100000][2];

    for (int i = 0; i < n; i++) {
        team[i][0] = speed[i];
        team[i][1] = efficiency[i];
    }

    qsort(team, n, sizeof(team[0]), cmp);

    int minHeap[100000], heapSize = 0;

    for (int i = 0; i < n; i++) {
        if (heapSize == k) {
            totalSpeed -= minHeap[0];
            minHeap[0] = team[i][0];
            // Min-heapify
            int j = 0;
            while (2 * j + 1 < heapSize) {
                int child = 2 * j + 1;
                if (child + 1 < heapSize && minHeap[child] > minHeap[child + 1]) {
                    child++;
                }
                if (minHeap[j] <= minHeap[child]) break;
                int temp = minHeap[j];
                minHeap[j] = minHeap[child];
                minHeap[child] = temp;
                j = child;
            }
        } else {
            minHeap[heapSize++] = team[i][0];
        }

        totalSpeed += team[i][0];
        long currentPerformance = totalSpeed * team[i][1];
        if (currentPerformance > maxPerformance) {
            maxPerformance = currentPerformance;
        }
    }

    return maxPerformance % MOD;
}