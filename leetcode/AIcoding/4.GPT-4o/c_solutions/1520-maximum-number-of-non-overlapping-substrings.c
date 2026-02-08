#define MAX(a, b) ((a) > (b) ? (a) : (b))

int maxNonOverlappingSubstrings(char *s, int* returnSize) {
    int n = strlen(s);
    int last[26], start[26], end[26];
    memset(last, -1, sizeof(last));
    memset(start, -1, sizeof(start));
    memset(end, -1, sizeof(end));

    for (int i = 0; i < n; i++) {
        int idx = s[i] - 'a';
        if (start[idx] == -1) start[idx] = i;
        last[idx] = i;
        end[idx] = MAX(end[idx], i);
    }

    int count = 0;
    int currEnd = -1;
    int resCount = 0;

    for (int i = 0; i < 26; i++) {
        if (start[i] != -1) {
            if (currEnd < last[i]) {
                count++;
                currEnd = end[i];
                resCount = MAX(resCount, count);
            } else if (currEnd >= last[i]) {
                count++;
            }
        }
        if (currEnd < end[i]) {
            currEnd = end[i];
        }
    }

    *returnSize = count;
    return resCount;
}