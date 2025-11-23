#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char* clearDigits(char* s) {
    int n = strlen(s);
    char* result = (char*)malloc(sizeof(char) * (n + 1));
    int res_idx = 0;

    for (int i = 0; i < n; i++) {
        char current_char = s[i];
        if (isdigit(current_char)) {
            if (res_idx > 0 && !isdigit(result[res_idx - 1])) {
                res_idx--;
            }
        } else {
            result[res_idx++] = current_char;
        }
    }

    result[res_idx] = '\0';
    return result;
}