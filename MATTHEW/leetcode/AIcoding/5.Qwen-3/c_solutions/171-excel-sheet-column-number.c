#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int titleToNumber(char * columnTitle) {
    int result = 0;
    while (*columnTitle) {
        result = result * 26 + (*columnTitle++ - 'A' + 1);
    }
    return result;
}