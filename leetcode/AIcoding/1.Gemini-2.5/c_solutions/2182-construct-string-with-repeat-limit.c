#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

char* repeatLimitedString(char* s, int repeatLimit) {
    int counts[26] = {0};
    int n = strlen(s);
    for (int i = 0; i < n; i++) {
        counts[s[i] - 'a']++;
    }

    char* result = (char*)malloc(sizeof(char) * (n + 1));
    int res_idx = 0;

    for (int i = 25; i >= 0; ) {
        if (counts[i] == 0) {
            i--;
            continue;
        }

        int num_to_append = (counts[i] < repeatLimit) ? counts[i] : repeatLimit;
        for (int k = 0; k < num_to_append; k++) {
            result[res_idx++] = (char)('a' + i);
        }
        counts[i] -= num_to_append;

        if (counts[i] > 0) {
            int j = i - 1;
            while (j >= 0 && counts[j] == 0) {
                j--;
            }

            if (j >= 0) {
                result[res_idx++] = (char)('a' + j);
                counts[j]--;
            } else {
                break;
            }
        } else {
            i--;
        }
    }

    result[res_idx] = '\0';
    return result;
}