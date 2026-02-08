#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * maxValue(char * n, int x){
    int len = strlen(n);
    char *result = (char *)malloc(sizeof(char) * (len + 2));
    int i = 0;
    if (n[0] == '-') {
        i = 1;
        while (i < len && n[i] <= (x + '0')) {
            i++;
        }
        strncpy(result, n, i);
        result[i] = x + '0';
        strncpy(result + i + 1, n + i, len - i);
        result[len + 1] = '\0';
    } else {
        while (i < len && n[i] >= (x + '0')) {
            i++;
        }
        strncpy(result, n, i);
        result[i] = x + '0';
        strncpy(result + i + 1, n + i, len - i);
        result[len + 1] = '\0';
    }
    return result;
}