#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *num;
    int len;
} Num;

int isAdditiveNumber(char *num) {
    int n = strlen(num);
    for (int i = 1; i < n - 1; i++) {
        if (i > 1 && num[0] == '0') break;
        for (int j = i + 1; j < n; j++) {
            if (j > i + 1 && num[i] == '0') break;
            long first = strtol(num, NULL, 10);
            long second = strtol(num + i, NULL, 10);
            int k = j;
            while (k < n) {
                long third = first + second;
                char temp[20];
                sprintf(temp, "%ld", third);
                int len = strlen(temp);
                if (strncmp(num + k, temp, len) != 0) break;
                k += len;
                first = second;
                second = third;
            }
            if (k == n) return 1;
        }
    }
    return 0;
}