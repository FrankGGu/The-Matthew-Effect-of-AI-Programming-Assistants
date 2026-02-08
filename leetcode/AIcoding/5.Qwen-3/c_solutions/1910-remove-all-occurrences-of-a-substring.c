#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* removeOccurrences(char* s, char* part) {
    int s_len = strlen(s);
    int part_len = strlen(part);
    if (part_len == 0 || s_len < part_len) {
        return strdup(s);
    }

    char* result = (char*)malloc((s_len + 1) * sizeof(char));
    int result_index = 0;
    int i = 0;

    while (i <= s_len - part_len) {
        int j;
        for (j = 0; j < part_len; j++) {
            if (s[i + j] != part[j]) {
                break;
            }
        }
        if (j == part_len) {
            i += part_len;
        } else {
            result[result_index++] = s[i++];
        }
    }

    while (i < s_len) {
        result[result_index++] = s[i++];
    }
    result[result_index] = '\0';

    return result;
}