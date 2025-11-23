#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(char*)a - *(char*)b);
}

long long smallestNumber(long long num) {
    if (num == 0) return 0;

    int isNegative = num < 0;
    if (isNegative) num = -num;

    char str[20];
    sprintf(str, "%lld", num);
    int len = strlen(str);

    qsort(str, len, sizeof(char), compare);

    if (isNegative) {
        for (int i = len - 1; i > 0; i--) {
            if (str[i] != '0') {
                char temp = str[0];
                str[0] = str[i];
                str[i] = temp;
                break;
            }
        }
        for (int i = 0; i < len; i++) {
            if (str[i] != '0') {
                char temp = str[0];
                str[0] = str[i];
                str[i] = temp;
                break;
            }
        }
        return -atoll(str);
    } else {
        return atoll(str);
    }
}