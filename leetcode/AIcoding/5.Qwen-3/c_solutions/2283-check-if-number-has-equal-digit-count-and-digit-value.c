#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

bool digitCount(char* num) {
    int count[10] = {0};
    int len = 0;
    while (num[len] != '\0') {
        len++;
    }
    for (int i = 0; i < len; i++) {
        int digit = num[i] - '0';
        count[digit]++;
    }
    for (int i = 0; i < len; i++) {
        int digit = num[i] - '0';
        if (count[digit] != i + 1) {
            return false;
        }
    }
    return true;
}