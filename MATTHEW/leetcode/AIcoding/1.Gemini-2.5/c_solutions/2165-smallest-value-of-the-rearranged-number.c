#include <stdlib.h>
#include <string.h>
#include <stdio.h>

int compare_asc(const void *a, const void *b) {
    return (*(char*)a - *(char*)b);
}

int compare_desc(const void *a, const void *b) {
    return (*(char*)b - *(char*)a);
}

long long smallestNumber(long long num) {
    if (num == 0) {
        return 0;
    }

    char s[20];
    int len;
    long long result;
    int is_negative = (num < 0);

    if (is_negative) {
        sprintf(s, "%lld", -num);
    } else {
        sprintf(s, "%lld", num);
    }
    len = strlen(s);

    if (is_negative) {
        qsort(s, len, sizeof(char), compare_desc);
    } else {
        qsort(s, len, sizeof(char), compare_asc);
        if (s[0] == '0') {
            for (int i = 1; i < len; i++) {
                if (s[i] != '0') {
                    char temp = s[0];
                    s[0] = s[i];
                    s[i] = temp;
                    break;
                }
            }
        }
    }

    sscanf(s, "%lld", &result);

    if (is_negative) {
        return -result;
    } else {
        return result;
    }
}