#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char** restoreIpAddresses(char* s, int* returnSize) {
    *returnSize = 0;
    char** result = (char**)malloc(0);
    int len = strlen(s);
    if (len < 4 || len > 12) return result;

    for (int a = 1; a <= 3; a++) {
        for (int b = 1; b <= 3; b++) {
            for (int c = 1; c <= 3; c++) {
                for (int d = 1; d <= 3; d++) {
                    if (a + b + c + d != len) continue;
                    char part1[4], part2[4], part3[4], part4[4];
                    strncpy(part1, s, a);
                    part1[a] = '\0';
                    strncpy(part2, s + a, b);
                    part2[b] = '\0';
                    strncpy(part3, s + a + b, c);
                    part3[c] = '\0';
                    strncpy(part4, s + a + b + c, d);
                    part4[d] = '\0';

                    if (strlen(part1) > 1 && part1[0] == '0') continue;
                    if (strlen(part2) > 1 && part2[0] == '0') continue;
                    if (strlen(part3) > 1 && part3[0] == '0') continue;
                    if (strlen(part4) > 1 && part4[0] == '0') continue;

                    int val1 = atoi(part1);
                    int val2 = atoi(part2);
                    int val3 = atoi(part3);
                    int val4 = atoi(part4);

                    if (val1 >= 0 && val1 <= 255 && val2 >= 0 && val2 <= 255 && val3 >= 0 && val3 <= 255 && val4 >= 0 && val4 <= 255) {
                        char* ip = (char*)malloc(16);
                        sprintf(ip, "%s.%s.%s.%s", part1, part2, part3, part4);
                        result = (char**)realloc(result, (*returnSize + 1) * sizeof(char*));
                        result[*returnSize] = ip;
                        (*returnSize)++;
                    }
                }
            }
        }
    }

    return result;
}