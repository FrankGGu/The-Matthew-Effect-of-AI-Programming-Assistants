#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* start;
    char* end;
} Interval;

int compare(const void* a, const void* b) {
    return ((Interval*)a)->start - ((Interval*)b)->start;
}

char** maxNumOfNonOverlappingSubstrings(char* s, int* returnSize) {
    int n = strlen(s);
    int* count = (int*)calloc(26, sizeof(int));
    for (int i = 0; i < n; i++) {
        count[s[i] - 'a']++;
    }

    int left = 0;
    int right = 0;
    int unique = 0;
    Interval* intervals = (Interval*)malloc(n * sizeof(Interval));
    int intervalCount = 0;

    while (right < n) {
        if (count[s[right] - 'a'] == 1) {
            unique++;
        }
        if (unique == 1) {
            left = right;
        }
        if (unique > 1) {
            int i = left;
            while (i <= right) {
                if (count[s[i] - 'a'] == 1) {
                    unique--;
                }
                i++;
            }
            unique = 0;
            left = right + 1;
        }
        right++;
    }

    int* used = (int*)calloc(n, sizeof(int));
    int* pos = (int*)malloc(n * sizeof(int));
    for (int i = 0; i < n; i++) {
        pos[i] = i;
    }

    for (int i = 0; i < n; i++) {
        if (count[s[i] - 'a'] == 1) {
            used[i] = 1;
        }
    }

    for (int i = 0; i < n; i++) {
        if (used[i]) {
            intervals[intervalCount].start = &s[i];
            intervals[intervalCount].end = &s[i];
            intervalCount++;
        }
    }

    qsort(intervals, intervalCount, sizeof(Interval), compare);

    char** result = (char**)malloc(intervalCount * sizeof(char*));
    *returnSize = 0;

    int lastEnd = -1;
    for (int i = 0; i < intervalCount; i++) {
        if (intervals[i].start > lastEnd) {
            int len = intervals[i].end - intervals[i].start + 1;
            result[*returnSize] = (char*)malloc(len + 1);
            strncpy(result[*returnSize], intervals[i].start, len);
            result[*returnSize][len] = '\0';
            (*returnSize)++;
            lastEnd = intervals[i].end;
        }
    }

    free(count);
    free(intervals);
    free(used);
    free(pos);
    return result;
}