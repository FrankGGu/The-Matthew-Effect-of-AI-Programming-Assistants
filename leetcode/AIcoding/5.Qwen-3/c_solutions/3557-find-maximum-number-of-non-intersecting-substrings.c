#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

char** maxNumOfSubstrings(char* s, int* returnSize) {
    int n = strlen(s);
    int start[26] = {0}, end[26] = {0};
    for (int i = 0; i < 26; i++) {
        start[i] = n;
        end[i] = -1;
    }
    for (int i = 0; i < n; i++) {
        int c = s[i] - 'a';
        start[c] = fmin(start[c], i);
        end[c] = fmax(end[c], i);
    }

    int intervals[26][2];
    int count = 0;
    for (int i = 0; i < 26; i++) {
        if (start[i] <= end[i]) {
            intervals[count][0] = start[i];
            intervals[count][1] = end[i];
            count++;
        }
    }

    qsort(intervals, count, sizeof(intervals[0]), compare);

    char** result = (char**)malloc(sizeof(char*) * count);
    *returnSize = 0;

    int last = -1;
    for (int i = 0; i < count; i++) {
        if (intervals[i][0] > last) {
            (*returnSize)++;
            result[*returnSize - 1] = (char*)malloc(intervals[i][1] - intervals[i][0] + 2);
            strncpy(result[*returnSize - 1], s + intervals[i][0], intervals[i][1] - intervals[i][0] + 1);
            result[*returnSize - 1][intervals[i][1] - intervals[i][0] + 1] = '\0';
            last = intervals[i][1];
        }
    }

    return result;
}