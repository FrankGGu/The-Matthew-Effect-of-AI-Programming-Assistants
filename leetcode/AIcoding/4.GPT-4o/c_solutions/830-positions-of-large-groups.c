#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int start;
    int end;
} Interval;

int** largeGroupPositions(char *s, int* returnSize, int** returnColumnSizes) {
    int len = strlen(s);
    int capacity = 10;
    Interval* intervals = malloc(capacity * sizeof(Interval));
    *returnSize = 0;

    for (int i = 0; i < len; ) {
        int j = i;
        while (j < len && s[j] == s[i]) {
            j++;
        }
        if (j - i >= 3) {
            if (*returnSize >= capacity) {
                capacity *= 2;
                intervals = realloc(intervals, capacity * sizeof(Interval));
            }
            intervals[*returnSize].start = i;
            intervals[*returnSize].end = j - 1;
            (*returnSize)++;
        }
        i = j;
    }

    *returnColumnSizes = malloc(*returnSize * sizeof(int));
    for (int i = 0; i < *returnSize; i++) {
        (*returnColumnSizes)[i] = 2;
    }

    int** result = malloc(*returnSize * sizeof(int*));
    for (int i = 0; i < *returnSize; i++) {
        result[i] = malloc(2 * sizeof(int));
        result[i][0] = intervals[i].start;
        result[i][1] = intervals[i].end;
    }

    free(intervals);
    return result;
}