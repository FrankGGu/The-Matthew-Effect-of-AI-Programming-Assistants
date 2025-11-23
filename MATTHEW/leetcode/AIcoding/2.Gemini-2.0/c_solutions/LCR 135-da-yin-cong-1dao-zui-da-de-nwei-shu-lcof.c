#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * countAndSay(int n){
    if (n == 1) {
        return strdup("1");
    }

    char *prev = countAndSay(n - 1);
    int len = strlen(prev);
    char *result = (char *)malloc(2 * len * sizeof(char));
    int count = 1;
    int index = 0;

    for (int i = 0; i < len; i++) {
        if (i + 1 < len && prev[i] == prev[i + 1]) {
            count++;
        } else {
            result[index++] = count + '0';
            result[index++] = prev[i];
            count = 1;
        }
    }

    result[index] = '\0';
    free(prev);
    return result;
}