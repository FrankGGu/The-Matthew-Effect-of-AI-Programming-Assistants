#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int titleToNumber(char * columnTitle){
    int result = 0;
    int len = strlen(columnTitle);
    for (int i = 0; i < len; i++) {
        result = result * 26 + (columnTitle[i] - 'A' + 1);
    }
    return result;
}