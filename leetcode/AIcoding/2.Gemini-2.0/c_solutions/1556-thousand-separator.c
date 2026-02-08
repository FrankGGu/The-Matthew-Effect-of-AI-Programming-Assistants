#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * thousandSeparator(int n) {
    char num_str[12];
    sprintf(num_str, "%d", n);
    int len = strlen(num_str);
    int new_len = len + (len - 1) / 3;
    char *result = (char *)malloc(sizeof(char) * (new_len + 1));
    result[new_len] = '\0';
    int i = len - 1, j = new_len - 1, count = 0;
    while (i >= 0) {
        result[j--] = num_str[i--];
        count++;
        if (count == 3 && i >= 0) {
            result[j--] = '.';
            count = 0;
        }
    }
    return result;
}