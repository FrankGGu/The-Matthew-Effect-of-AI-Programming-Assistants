int min(int a, int b) {
    return a < b ? a : b;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int storeWater(int* bucket, int bucketSize, int* vat, int vatSize) {
    int maxVat = 0;
    for (int i = 0; i < vatSize; i++) {
        maxVat = max(maxVat, vat[i]);
    }
    if (maxVat == 0) {
        return 0;
    }

    int ans = INT_MAX;
    for (int k = 1; k <= maxVat; k++) {
        int t = 0;
        for (int i = 0; i < bucketSize; i++) {
            t += max(0, (vat[i] + k - 1) / k - bucket[i]);
        }
        ans = min(ans, t + k);
        if (k >= ans) {
            break;
        }
    }
    return ans;
}