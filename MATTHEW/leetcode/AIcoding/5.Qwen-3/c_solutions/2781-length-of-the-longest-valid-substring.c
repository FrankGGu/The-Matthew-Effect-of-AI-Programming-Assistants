#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int longestValidSubstring(char* s) {
    int n = strlen(s);
    int max_len = 0;
    int last_invalid = -1;
    int* map = (int*)calloc(26, sizeof(int));

    for (int i = 0; i < n; i++) {
        int idx = s[i] - 'a';
        map[idx] = i;

        for (int j = 0; j < 26; j++) {
            if (map[j] > last_invalid) {
                last_invalid = map[j];
            }
        }

        max_len = fmax(max_len, i - last_invalid);
    }

    free(map);
    return max_len;
}