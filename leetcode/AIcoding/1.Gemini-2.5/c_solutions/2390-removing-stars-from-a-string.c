#include <string.h>
#include <stdlib.h>

char *removeStars(char *s) {
    int n = strlen(s);
    char *result = (char *)malloc(sizeof(char) * (n + 1));
    int result_idx = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == '*') {
            if (result_idx > 0) {
                result_idx--;
            }
        } else {
            result[result_idx++] = s[i];
        }
    }
    result[result_idx] = '\0';
    return result;
}