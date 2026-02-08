#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int isValid(char *s) {
    int len = strlen(s);
    if (len > 3 || len == 0) return 0;
    if (s[0] == '0' && len > 1) return 0;
    int num = atoi(s);
    if (num > 255) return 0;
    return 1;
}

char ** restoreIpAddresses(char * s, int* returnSize){
    int len = strlen(s);
    if (len < 4 || len > 12) {
        *returnSize = 0;
        return NULL;
    }

    char **result = (char **)malloc(sizeof(char *) * 1000);
    *returnSize = 0;

    for (int i = 1; i < 4 && i < len - 2; i++) {
        for (int j = i + 1; j < i + 4 && j < len - 1; j++) {
            for (int k = j + 1; k < j + 4 && k < len; k++) {
                if (k + 1 > len) continue;

                char s1[4] = {0}, s2[4] = {0}, s3[4] = {0}, s4[4] = {0};
                strncpy(s1, s, i);
                strncpy(s2, s + i, j - i);
                strncpy(s3, s + j, k - j);
                strncpy(s4, s + k, len - k);

                if (isValid(s1) && isValid(s2) && isValid(s3) && isValid(s4)) {
                    result[*returnSize] = (char *)malloc(sizeof(char) * (len + 4));
                    sprintf(result[*returnSize], "%s.%s.%s.%s", s1, s2, s3, s4);
                    (*returnSize)++;
                }
            }
        }
    }

    return result;
}