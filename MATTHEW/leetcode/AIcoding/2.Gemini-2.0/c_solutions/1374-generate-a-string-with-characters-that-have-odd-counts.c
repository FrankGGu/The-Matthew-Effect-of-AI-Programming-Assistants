#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * generateTheString(int n){
    char *str = (char *)malloc(sizeof(char) * (n + 1));
    if (n % 2 == 0) {
        memset(str, 'a', n - 1);
        str[n - 1] = 'b';
    } else {
        memset(str, 'a', n);
    }
    str[n] = '\0';
    return str;
}