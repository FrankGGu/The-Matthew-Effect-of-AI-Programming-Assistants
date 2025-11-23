int minimumBuckets(char* hamsters) {
    int n = strlen(hamsters);
    int buckets = 0;

    for (int i = 0; i < n; i++) {
        if (hamsters[i] == 'H') {
            if (i > 0 && hamsters[i - 1] == 'B') {
                continue;
            }
            if (i < n - 1 && hamsters[i + 1] == '.') {
                hamsters[i + 1] = 'B';
                buckets++;
            } else if (i > 0 && hamsters[i - 1] == '.') {
                hamsters[i - 1] = 'B';
                buckets++;
            } else {
                return -1;
            }
        }
    }

    return buckets;
}