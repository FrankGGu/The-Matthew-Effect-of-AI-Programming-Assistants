typedef struct {
    char c;
    int count;
} CharCount;

int cmp(const void* a, const void* b) {
    return ((CharCount*)b)->count - ((CharCount*)a)->count;
}

char* reorganizeString(char* s) {
    int n = strlen(s);
    if (n == 0) return "";

    CharCount count[26] = {0};
    for (int i = 0; i < 26; i++) {
        count[i].c = 'a' + i;
    }

    for (int i = 0; i < n; i++) {
        count[s[i] - 'a'].count++;
    }

    qsort(count, 26, sizeof(CharCount), cmp);

    if (count[0].count > (n + 1) / 2) {
        return "";
    }

    char* result = (char*)malloc((n + 1) * sizeof(char));
    result[n] = '\0';

    int idx = 0;
    for (int i = 0; i < 26; i++) {
        while (count[i].count > 0) {
            if (idx >= n) idx = 1;
            result[idx] = count[i].c;
            count[i].count--;
            idx += 2;
        }
    }

    return result;
}