#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int *partitionLabels(char *s, int *returnSize) {
    int last[26];
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        last[s[i] - 'a'] = i;
    }

    int *result = (int *)malloc(n * sizeof(int));
    *returnSize = 0;

    int start = 0;
    int end = 0;
    for (int i = 0; i < n; i++) {
        end = (end > last[s[i] - 'a']) ? end : last[s[i] - 'a'];
        if (i == end) {
            result[(*returnSize)++] = end - start + 1;
            start = i + 1;
        }
    }

    return result;
}