typedef struct {
    int start;
    int end;
} Interval;

int cmp(const void* a, const void* b) {
    Interval* i1 = (Interval*)a;
    Interval* i2 = (Interval*)b;
    return i1->end - i2->end;
}

char** maxNumOfSubstrings(char* s, int* returnSize) {
    int n = strlen(s);
    int left[26], right[26];
    for (int i = 0; i < 26; i++) {
        left[i] = n;
        right[i] = -1;
    }

    for (int i = 0; i < n; i++) {
        int idx = s[i] - 'a';
        if (i < left[idx]) left[idx] = i;
        if (i > right[idx]) right[idx] = i;
    }

    Interval intervals[26];
    int count = 0;

    for (int i = 0; i < 26; i++) {
        if (left[i] == n) continue;

        int l = left[i], r = right[i];
        bool valid = true;
        for (int j = l; j <= r; j++) {
            int idx = s[j] - 'a';
            if (left[idx] < l) {
                valid = false;
                break;
            }
            if (right[idx] > r) {
                r = right[idx];
            }
        }

        if (valid) {
            intervals[count].start = l;
            intervals[count].end = r;
            count++;
        }
    }

    qsort(intervals, count, sizeof(Interval), cmp);

    char** res = (char**)malloc(count * sizeof(char*));
    int resCount = 0;
    int lastEnd = -1;

    for (int i = 0; i < count; i++) {
        if (intervals[i].start > lastEnd) {
            int len = intervals[i].end - intervals[i].start + 1;
            res[resCount] = (char*)malloc((len + 1) * sizeof(char));
            strncpy(res[resCount], s + intervals[i].start, len);
            res[resCount][len] = '\0';
            resCount++;
            lastEnd = intervals[i].end;
        }
    }

    *returnSize = resCount;
    return res;
}