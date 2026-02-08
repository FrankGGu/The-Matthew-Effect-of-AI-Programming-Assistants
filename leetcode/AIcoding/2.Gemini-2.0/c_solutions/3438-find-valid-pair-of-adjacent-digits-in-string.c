#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isValid(char* num) {
    int len = strlen(num);
    for (int i = 0; i < len - 1; i++) {
        if ((num[i] - '0') % 2 == 0 && (num[i+1] - '0') % 2 == 0) {
            return true;
        }
        if ((num[i] - '0') % 2 != 0 && (num[i+1] - '0') % 2 != 0) {
            return true;
        }
    }
    return false;
}