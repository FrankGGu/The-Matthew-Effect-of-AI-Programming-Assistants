bool hasAllCodes(char* s, int k) {
    int n = strlen(s);
    if (n < k) return false;

    int total = 1 << k;
    int mask = total - 1;
    bool* seen = (bool*)calloc(total, sizeof(bool));
    int count = 0;

    int hash = 0;
    for (int i = 0; i < k; i++) {
        hash = (hash << 1) | (s[i] - '0');
    }
    seen[hash] = true;
    count++;

    for (int i = k; i < n; i++) {
        hash = ((hash << 1) | (s[i] - '0')) & mask;
        if (!seen[hash]) {
            seen[hash] = true;
            count++;
            if (count == total) {
                free(seen);
                return true;
            }
        }
    }

    free(seen);
    return count == total;
}