#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * largestOddNumber(char * num){
    int len = strlen(num);
    for (int i = len - 1; i >= 0; i--) {
        if ((num[i] - '0') % 2 != 0) {
            num[i + 1] = '\0';
            return num;
        }
    }
    num[0] = '\0';
    return num;
}