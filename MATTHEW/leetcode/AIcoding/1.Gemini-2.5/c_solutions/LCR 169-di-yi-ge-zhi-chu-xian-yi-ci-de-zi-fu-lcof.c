#include <stdlib.h>
#include <string.h>

char* removeOuterParentheses(char* s) {
    if (s == NULL) {
        return NULL;
    }

    int n = strlen(s);
    char* result = (char*)malloc(sizeof(char) * (n + 1));
    if (result == NULL) {
        return NULL;
    }

    int result_idx = 0;
    int open_count = 0;

    for (int i = 0; i < n; i++) {
        if (s[i] == '(') {
            if (open_count > 0) {
                result[result_idx++] = s[i];
            }
            open_count++;
        } else {
            open_count--;
            if (open_count > 0) {
                result[result_idx++] = s[i];
            }
        }
    }

    result[result_idx] = '\0';
    return result;
}