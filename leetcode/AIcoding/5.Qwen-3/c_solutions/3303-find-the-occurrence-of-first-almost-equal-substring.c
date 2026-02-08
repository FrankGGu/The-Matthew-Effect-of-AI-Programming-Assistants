#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findFirstAlmostEqualSubstring(char *s, char *t) {
    int len_s = strlen(s);
    int len_t = strlen(t);

    if (len_t == 0 || len_s < len_t) return -1;

    for (int i = 0; i <= len_s - len_t; i++) {
        int diff = 0;
        for (int j = 0; j < len_t; j++) {
            if (s[i + j] != t[j]) {
                diff++;
                if (diff > 1) break;
            }
        }
        if (diff == 1) return i;
    }

    return -1;
}