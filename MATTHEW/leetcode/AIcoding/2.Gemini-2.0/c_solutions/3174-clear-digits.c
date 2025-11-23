#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int clearDigits(int num) {
    char str[12];
    sprintf(str, "%d", num);
    int len = strlen(str);
    int result = 0;
    int powerOfTen = 1;

    for (int i = len - 1; i >= 0; i--) {
        if (str[i] != '0') {
            result += (str[i] - '0') * powerOfTen;
            powerOfTen *= 10;
        }
    }

    return result;
}