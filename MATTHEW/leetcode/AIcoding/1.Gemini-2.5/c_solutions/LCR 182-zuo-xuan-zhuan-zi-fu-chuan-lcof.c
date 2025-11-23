#include <stdlib.h>
#include <string.h>
#include <ctype.h>

char* dynamicPassword(char* s) {
    if (s == NULL) {
        char* empty_str = (char*)malloc(sizeof(char));
        if (empty_str == NULL) {
            return NULL;
        }
        empty_str[0] = '\0';
        return empty_str;
    }

    int len = strlen(s);
    int digitCount = 0;
    for (int i = 0; i < len; i++) {
        if (isdigit(s[i])) {
            digitCount++;
        }
    }

    char* result = (char*)malloc(sizeof(char) * (digitCount + 1));
    if (result == NULL) {
        return NULL;
    }

    int k = 0;
    for (int i = 0; i < len; i++) {
        if (isdigit(s[i])) {
            result[k++] = s[i];
        }
    }
    result[k] = '\0';

    return result;
}