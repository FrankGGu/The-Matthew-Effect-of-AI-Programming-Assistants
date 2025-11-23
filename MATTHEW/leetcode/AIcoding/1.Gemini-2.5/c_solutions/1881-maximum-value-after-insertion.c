#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

char *maxValue(char *n, int x) {
    int len = strlen(n);
    char *result = (char *)malloc(len + 2);

    char x_char = (char)(x + '0');
    bool is_negative = (n[0] == '-');
    int insert_idx = len;

    if (is_negative) {
        for (int i = 1; i < len; i++) {
            if (x_char < n[i]) {
                insert_idx = i;
                break;
            }
        }
    } else {
        for (int i = 0; i < len; i++) {
            if (x_char > n[i]) {
                insert_idx = i;
                break;
            }
        }
    }

    int res_idx = 0;
    for (int i = 0; i < insert_idx; i++) {
        result[res_idx++] = n[i];
    }
    result[res_idx++] = x_char;
    for (int i = insert_idx; i < len; i++) {
        result[res_idx++] = n[i];
    }
    result[res_idx] = '\0';

    return result;
}