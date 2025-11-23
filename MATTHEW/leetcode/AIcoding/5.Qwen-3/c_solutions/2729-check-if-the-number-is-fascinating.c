#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isFascinating(char* num) {
    if (strlen(num) != 10) return false;

    int count[10] = {0};
    for (int i = 0; i < 10; i++) {
        int digit = num[i] - '0';
        if (digit == 0 || count[digit] > 0) return false;
        count[digit]++;
    }

    return true;
}