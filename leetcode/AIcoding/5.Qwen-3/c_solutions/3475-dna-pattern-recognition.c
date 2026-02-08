#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* findRepeatedDnaSequences(char* s) {
    int len = strlen(s);
    if (len < 10) return NULL;

    char* result = (char*)malloc(sizeof(char) * (len + 1));
    int result_len = 0;
    int i;

    int hash[26 * 26 * 26 * 26 * 26] = {0};
    int current_hash = 0;

    for (i = 0; i < 10; i++) {
        current_hash = (current_hash << 2) | (s[i] - 'A' + 1);
    }

    hash[current_hash] = 1;

    for (i = 10; i < len; i++) {
        current_hash = ((current_hash << 2) & 0x3FFFFFFF) | (s[i] - 'A' + 1);
        if (hash[current_hash] == 1) {
            int start = i - 9;
            int j;
            for (j = 0; j < 10; j++) {
                result[result_len++] = s[start + j];
            }
            result[result_len++] = ',';
        } else {
            hash[current_hash]++;
        }
    }

    if (result_len > 0) {
        result[result_len - 1] = '\0';
    } else {
        result[0] = '\0';
    }

    return result;
}