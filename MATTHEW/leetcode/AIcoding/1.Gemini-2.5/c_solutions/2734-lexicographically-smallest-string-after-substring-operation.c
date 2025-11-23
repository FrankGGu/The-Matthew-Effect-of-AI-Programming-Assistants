#include <string.h>

char *getSmallestString(char *s) {
    int n = strlen(s);
    int start_idx = -1;

    for (int i = 0; i < n; i++) {
        if (s[i] != 'a') {
            start_idx = i;
            break;
        }
    }

    if (start_idx == -1) {
        return s;
    }

    for (int i = start_idx; i < n; i++) {
        if (s[i] == 'a') {
            break;
        }
        s[i]--;
    }

    return s;
}