#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * strWithout3a3b(int a, int b){
    int len = a + b;
    char *result = (char *)malloc(sizeof(char) * (len + 1));
    result[len] = '\0';
    int i = 0;
    while (a > 0 || b > 0) {
        if (a > b) {
            if (i > 1 && result[i - 1] == 'a' && result[i - 2] == 'a') {
                result[i++] = 'b';
                b--;
            } else {
                result[i++] = 'a';
                a--;
            }
        } else {
            if (i > 1 && result[i - 1] == 'b' && result[i - 2] == 'b') {
                result[i++] = 'a';
                a--;
            } else {
                result[i++] = 'b';
                b--;
            }
        }
    }
    return result;
}