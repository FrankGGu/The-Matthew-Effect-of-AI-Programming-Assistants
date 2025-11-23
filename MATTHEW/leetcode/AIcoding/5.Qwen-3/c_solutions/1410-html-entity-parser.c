#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* entityParser(char* text) {
    int len = strlen(text);
    char* result = (char*)malloc((len + 1) * sizeof(char));
    int index = 0;

    for (int i = 0; i < len; i++) {
        if (text[i] == '&') {
            if (strncmp(text + i, "&quot;", 6) == 0) {
                result[index++] = '"';
                i += 5;
            } else if (strncmp(text + i, "&apos;", 6) == 0) {
                result[index++] = '\'';
                i += 5;
            } else if (strncmp(text + i, "&amp;", 5) == 0) {
                result[index++] = '&';
                i += 4;
            } else if (strncmp(text + i, "&lt;", 4) == 0) {
                result[index++] = '<';
                i += 3;
            } else if (strncmp(text + i, "&gt;", 4) == 0) {
                result[index++] = '>';
                i += 3;
            } else if (strncmp(text + i, "&frasl;", 8) == 0) {
                result[index++] = '/';
                i += 7;
            } else {
                result[index++] = '&';
            }
        } else {
            result[index++] = text[i];
        }
    }

    result[index] = '\0';
    return result;
}