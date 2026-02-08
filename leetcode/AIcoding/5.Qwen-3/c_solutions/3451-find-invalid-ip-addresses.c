#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MAX_IP 4
#define MAX_LEN 16

typedef struct {
    char* ip;
} Result;

Result* findInvalidIPs(char** ips, int ipsSize, int* returnSize) {
    Result* result = (Result*)malloc(ipsSize * sizeof(Result));
    *returnSize = 0;

    for (int i = 0; i < ipsSize; i++) {
        char* ip = ips[i];
        int valid = 1;
        int parts = 0;
        char* token = strtok(ip, ".");
        while (token != NULL) {
            parts++;
            if (parts > 4) {
                valid = 0;
                break;
            }
            if (strlen(token) > 3) {
                valid = 0;
                break;
            }
            for (int j = 0; j < strlen(token); j++) {
                if (!isdigit(token[j])) {
                    valid = 0;
                    break;
                }
            }
            if (!valid) break;
            int num = atoi(token);
            if (num < 0 || num > 255) {
                valid = 0;
                break;
            }
            if (strlen(token) > 1 && token[0] == '0') {
                valid = 0;
                break;
            }
            token = strtok(NULL, ".");
        }
        if (parts != 4 || !valid) {
            result[*returnSize].ip = strdup(ip);
            (*returnSize)++;
        }
    }

    return result;
}