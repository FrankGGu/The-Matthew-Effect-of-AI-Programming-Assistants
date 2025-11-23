#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* defangIPaddr(char* address) {
    int len = strlen(address);
    char* result = (char*)malloc(len + 7 * sizeof(char));
    int i = 0, j = 0;
    while (address[i] != '\0') {
        if (address[i] == '.') {
            result[j++] = '[';
            result[j++] = '.';
            result[j++] = ']';
        } else {
            result[j++] = address[i];
        }
        i++;
    }
    result[j] = '\0';
    return result;
}