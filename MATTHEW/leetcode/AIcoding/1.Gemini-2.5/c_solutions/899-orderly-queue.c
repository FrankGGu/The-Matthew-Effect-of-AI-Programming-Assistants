#include <stdlib.h>
#include <string.h>

int compareChars(const void *a, const void *b) {
    return (*(char*)a - *(char*)b);
}

char * orderlyQueue(char * s, int k) {
    int n = strlen(s);

    if (k == 1) {
        char *min_s = (char *)malloc(sizeof(char) * (n + 1));
        strcpy(min_s, s);

        char *current_s = (char *)malloc(sizeof(char) * (n + 1));
        strcpy(current_s, s);

        for (int i = 0; i < n; ++i) {
            char first_char = current_s[0];
            memmove(current_s, current_s + 1, n - 1);
            current_s[n - 1] = first_char;
            current_s[n] = '\0';

            if (strcmp(current_s, min_s) < 0) {
                strcpy(min_s, current_s);
            }
        }

        free(current_s);
        return min_s;

    } else {
        qsort(s, n, sizeof(char), compareChars);
        return s;
    }
}