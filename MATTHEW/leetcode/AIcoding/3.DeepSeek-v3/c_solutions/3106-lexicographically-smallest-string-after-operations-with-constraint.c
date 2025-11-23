char* getSmallestString(char* s, int k) {
    int n = strlen(s);
    char* res = (char*)malloc((n + 1) * sizeof(char));
    strcpy(res, s);

    for (int i = 0; i < n && k > 0; i++) {
        int current = res[i] - 'a';
        int dist1 = current;
        int dist2 = 26 - current;
        int min_dist = dist1 < dist2 ? dist1 : dist2;

        if (min_dist <= k) {
            res[i] = 'a';
            k -= min_dist;
        } else {
            res[i] = res[i] - k;
            k = 0;
        }
    }

    return res;
}