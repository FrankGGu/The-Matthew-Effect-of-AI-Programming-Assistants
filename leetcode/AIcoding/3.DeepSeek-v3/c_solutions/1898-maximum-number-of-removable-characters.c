int maximumRemovals(char* s, char* p, int* removable, int removableSize) {
    int slen = strlen(s);
    int plen = strlen(p);

    int left = 0, right = removableSize;
    int* removed = (int*)calloc(slen, sizeof(int));

    while (left < right) {
        int mid = left + (right - left + 1) / 2;

        for (int i = 0; i < slen; i++) removed[i] = 0;
        for (int i = 0; i < mid; i++) removed[removable[i]] = 1;

        int j = 0;
        for (int i = 0; i < slen && j < plen; i++) {
            if (!removed[i] && s[i] == p[j]) {
                j++;
            }
        }

        if (j == plen) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }

    free(removed);
    return left;
}