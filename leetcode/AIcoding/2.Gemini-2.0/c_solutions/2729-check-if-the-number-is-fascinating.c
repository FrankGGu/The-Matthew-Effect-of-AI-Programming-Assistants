#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool isFascinating(int n) {
    char str[10];
    char combined[20] = "";
    sprintf(str, "%d", n);
    strcat(combined, str);
    sprintf(str, "%d", 2 * n);
    strcat(combined, str);
    sprintf(str, "%d", 3 * n);
    strcat(combined, str);

    int len = strlen(combined);
    if (len != 9) {
        return false;
    }

    int count[10] = {0};
    for (int i = 0; i < len; i++) {
        if (combined[i] == '0') {
            return false;
        }
        count[combined[i] - '0']++;
    }

    for (int i = 1; i <= 9; i++) {
        if (count[i] != 1) {
            return false;
        }
    }

    return true;
}