#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* freqAlphabets(char* s) {
    int len = strlen(s);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int index = 0;

    for (int i = 0; i < len; i++) {
        if (i + 2 < len && s[i + 2] == '#') {
            int num = (s[i] - '0') * 10 + (s[i + 1] - '0');
            result[index++] = 'a' + num - 1;
            i += 2;
        } else {
            result[index++] = 'a' + (s[i] - '0') - 1;
        }
    }

    result[index] = '\0';
    return result;
}