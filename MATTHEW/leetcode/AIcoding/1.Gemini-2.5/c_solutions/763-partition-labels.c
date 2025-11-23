#include <string.h>
#include <stdlib.h>

int* partitionLabels(char * s, int* returnSize) {
    int last_occurrence[26];
    int n = strlen(s);

    for (int i = 0; i < n; i++) {
        last_occurrence[s[i] - 'a'] = i;
    }

    int* result = (int*)malloc(sizeof(int) * n);
    if (result == NULL) {
        *returnSize = 0;
        return NULL;
    }

    int result_idx = 0;
    int start = 0;
    int max_reach = 0;

    for (int i = 0; i < n; i++) {
        if (last_occurrence[s[i] - 'a'] > max_reach) {
            max_reach = last_occurrence[s[i] - 'a'];
        }

        if (i == max_reach) {
            result[result_idx++] = i - start + 1;
            start = i + 1;
        }
    }

    *returnSize = result_idx;
    return result;
}