#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char ** restoreIpAddresses(char * s, int* returnSize){
    int len = strlen(s);
    if (len < 4 || len > 12) {
        *returnSize = 0;
        return NULL;
    }

    char **result = (char **)malloc(sizeof(char *) * 1000);
    *returnSize = 0;

    char ip[16];

    void backtrack(int index, int dots) {
        if (dots == 4) {
            if (index == len) {
                result[*returnSize] = (char *)malloc(sizeof(char) * 16);
                strcpy(result[*returnSize], ip);
                (*returnSize)++;
            }
            return;
        }

        for (int i = 1; i <= 3 && index + i <= len; i++) {
            char segment[4];
            strncpy(segment, s + index, i);
            segment[i] = '\0';

            int value = atoi(segment);
            if (value > 255 || (segment[0] == '0' && i > 1)) {
                continue;
            }

            int ipLen = strlen(ip);
            sprintf(ip + ipLen, "%s", segment);
            if (dots < 3) {
                sprintf(ip + ipLen + i, ".");
            }

            backtrack(index + i, dots + 1);
            ip[ipLen] = '\0'; 
        }
    }

    ip[0] = '\0';
    backtrack(0, 0);

    return result;
}