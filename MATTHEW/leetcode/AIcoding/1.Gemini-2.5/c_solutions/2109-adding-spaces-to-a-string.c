#include <stdlib.h>
#include <string.h>

char* addSpaces(char* s, int* spaces, int spacesSize) {
    int s_len = strlen(s);
    int new_len = s_len + spacesSize;

    char* result = (char*)malloc((new_len + 1) * sizeof(char));

    if (result == NULL) {
        return NULL;
    }

    int s_idx = 0;
    int res_idx = 0;
    int spaces_idx = 0;

    while (s_idx < s_len) {
        if (spaces_idx < spacesSize && s_idx == spaces[spaces_idx]) {
            result[res_idx++] = ' ';
            spaces_idx++;
        }

        result[res_idx++] = s[s_idx++];
    }

    result[new_len] = '\0';

    return result;
}