#include <stdio.h>
#include <stdlib.h>

int numberOfSubarrays(char* s, int* pattern, int patternSize) {
    int n = strlen(s);
    int m = patternSize;
    int count = 0;
    int* diff = (int*)malloc((n - 1) * sizeof(int));

    for (int i = 0; i < n - 1; i++) {
        if (s[i] < s[i + 1]) {
            diff[i] = 1;
        } else if (s[i] > s[i + 1]) {
            diff[i] = -1;
        } else {
            diff[i] = 0;
        }
    }

    int* prefix = (int*)malloc((n) * sizeof(int));
    prefix[0] = 0;

    for (int i = 1; i < n - 1; i++) {
        prefix[i] = prefix[i - 1] + (diff[i - 1] == 0 ? 1 : 0);
    }

    for (int i = 0; i < n - m; i++) {
        int valid = 1;
        for (int j = 0; j < m; j++) {
            if (diff[i + j] != pattern[j]) {
                valid = 0;
                break;
            }
        }
        if (valid) {
            count++;
        }
    }

    free(diff);
    free(prefix);
    return count;
}