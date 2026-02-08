#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int maximum69Number (int num){
    char s[5];
    sprintf(s, "%d", num);

    for (int i = 0; s[i] != '\0'; i++) {
        if (s[i] == '6') {
            s[i] = '9';
            break;
        }
    }

    return atoi(s);
}