int minBuckets(char *houses, int housesSize) {
    int buckets = 0;
    int i = 0;

    while (i < housesSize) {
        if (houses[i] == 'H') {
            buckets++;
            if (i + 1 < housesSize && houses[i + 1] == '.'){
                i++;
            }
            if (i + 1 < housesSize && houses[i + 1] == 'H') {
                i += 2;
            } else {
                i++;
            }
        } else {
            i++;
        }
    }

    return buckets;
}