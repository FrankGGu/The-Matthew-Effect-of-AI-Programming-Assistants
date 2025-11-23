int comb(int n, int k) {
    if (k > n - k) k = n - k;
    long res = 1;
    for (int i = 0; i < k; i++) {
        res = res * (n - i) / (i + 1);
    }
    return (int)res;
}

char* kthSmallestPath(int* destination, int destinationSize, int k) {
    int v = destination[0];
    int h = destination[1];
    int n = v + h;

    char* res = (char*)malloc(sizeof(char) * (n + 1));
    int idx = 0;

    while (h > 0 && v > 0) {
        int count = comb(h + v - 1, v);
        if (k <= count) {
            res[idx++] = 'H';
            h--;
        } else {
            res[idx++] = 'V';
            k -= count;
            v--;
        }
    }

    while (h > 0) {
        res[idx++] = 'H';
        h--;
    }

    while (v > 0) {
        res[idx++] = 'V';
        v--;
    }

    res[idx] = '\0';
    return res;
}