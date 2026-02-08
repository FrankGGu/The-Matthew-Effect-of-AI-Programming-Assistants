int minimumBuckets(char* hamsters) {
    int n = strlen(hamsters);
    int count = 0;

    for (int i = 0; i < n; i++) {
        if (hamsters[i] == 'H') {
            if (i > 0 && hamsters[i - 1] == 'B') {
                continue;
            }
            if (i < n - 1 && hamsters[i + 1] == '.') {
                hamsters[i + 1] = 'B';
                count++;
            } else if (i > 0 && hamsters[i - 1] == '.') {
                hamsters[i - 1] = 'B';
                count++;
            } else {
                return -1;
            }
        }
    }

    return count;
}