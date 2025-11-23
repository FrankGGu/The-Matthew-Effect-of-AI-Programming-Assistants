#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_IP_ADDRESSES 500
#define MAX_IP_ADDRESS_LENGTH 16

char** restoreIpAddresses(char* s, int* returnSize) {
    int len = strlen(s);
    char** result = (char**)malloc(MAX_IP_ADDRESSES * sizeof(char*));
    *returnSize = 0;

    if (len < 4 || len > 12) {
        return result;
    }

    char ipAddress[MAX_IP_ADDRESS_LENGTH];

    void backtrack(int index, int segmentCount) {
        if (segmentCount == 4) {
            if (index == len) {
                result[*returnSize] = strdup(ipAddress);
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

            int ipAddressLen = strlen(ipAddress);
            if (segmentCount > 0) {
                strcat(ipAddress, ".");
            }
            strcat(ipAddress, segment);

            backtrack(index + i, segmentCount + 1);

            ipAddress[ipAddressLen] = '\0';
        }
    }

    ipAddress[0] = '\0';
    backtrack(0, 0);

    return result;
}