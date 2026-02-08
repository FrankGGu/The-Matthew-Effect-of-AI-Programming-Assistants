#include <string.h>
#include <stdlib.h>

int shiftDistance(char *s, char *t) {
    int len_s = strlen(s);
    int len_t = strlen(t);

    if (len_s != len_t) {
        return -1;
    }

    if (len_s == 0) {
        return 0;
    }

    char *s_s = (char *)malloc(sizeof(char) * (2 * len_s + 1));
    if (s_s == NULL) {
        return -1;
    }

    strcpy(s_s, s);
    strcat(s_s, s);

    char *found_ptr = strstr(s_s, t);

    int result;
    if (found_ptr == NULL) {
        result = -1;
    } else {
        result = found_ptr - s_s;
    }

    free(s_s);

    return result;
}