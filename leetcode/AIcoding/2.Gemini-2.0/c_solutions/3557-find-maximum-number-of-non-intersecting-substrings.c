#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int start;
    int end;
} Interval;

int compareInterval(const void *a, const void *b) {
    return ((Interval *)a)->end - ((Interval *)b)->end;
}

char ** maxNumOfSubstrings(char * s, int* returnSize){
    int n = strlen(s);
    int left[26];
    int right[26];
    for (int i = 0; i < 26; i++) {
        left[i] = n;
        right[i] = -1;
    }
    for (int i = 0; i < n; i++) {
        int c = s[i] - 'a';
        left[c] = fmin(left[c], i);
        right[c] = fmax(right[c], i);
    }
    Interval intervals[26];
    int intervalCount = 0;
    for (int i = 0; i < 26; i++) {
        if (left[i] < n) {
            int l = left[i];
            int r = right[i];
            for (int j = l; j <= r; j++) {
                int c = s[j] - 'a';
                l = fmin(l, left[c]);
                r = fmax(r, right[c]);
            }
            intervals[intervalCount].start = l;
            intervals[intervalCount].end = r;
            intervalCount++;
        }
    }
    qsort(intervals, intervalCount, sizeof(Interval), compareInterval);
    char **result = (char **)malloc(sizeof(char *) * (intervalCount + 1));
    int resultIndex = 0;
    int lastEnd = -1;
    for (int i = 0; i < intervalCount; i++) {
        if (intervals[i].start > lastEnd) {
            int len = intervals[i].end - intervals[i].start + 1;
            result[resultIndex] = (char *)malloc(sizeof(char) * (len + 1));
            strncpy(result[resultIndex], s + intervals[i].start, len);
            result[resultIndex][len] = '\0';
            resultIndex++;
            lastEnd = intervals[i].end;
        }
    }
    *returnSize = resultIndex;
    return result;
}