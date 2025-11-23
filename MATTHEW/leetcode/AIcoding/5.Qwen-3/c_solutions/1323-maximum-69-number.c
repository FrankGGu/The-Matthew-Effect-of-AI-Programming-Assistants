#include <stdio.h>
#include <stdlib.h>

int maximum69Number (int num) {
    char str[12];
    sprintf(str, "%d", num);
    for (int i = 0; str[i]; i++) {
        if (str[i] == '6') {
            str[i] = '9';
            break;
        }
    }
    return atoi(str);
}