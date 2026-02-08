#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * convert(char * s, int numRows){
    int len = strlen(s);
    if (numRows <= 1 || numRows >= len) {
        return s;
    }

    char *result = (char *)malloc(sizeof(char) * (len + 1));
    int k = 0;

    for (int i = 0; i < numRows; i++) {
        for (int j = i; j < len; j += 2 * numRows - 2) {
            result[k++] = s[j];
            if (i != 0 && i != numRows - 1 && (j + 2 * numRows - 2 - 2 * i) < len) {
                result[k++] = s[j + 2 * numRows - 2 - 2 * i];
            }
        }
    }

    result[len] = '\0';
    return result;
}