#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* strWithout3a3b(int a, int b) {
    char* result = (char*)malloc((a + b + 1) * sizeof(char));
    int i = 0;
    while (a > 0 || b > 0) {
        if (a > b) {
            result[i++] = 'a';
            a--;
            if (a > 0) {
                result[i++] = 'a';
                a--;
            }
        } else {
            result[i++] = 'b';
            b--;
            if (b > 0) {
                result[i++] = 'b';
                b--;
            }
        }
    }
    result[i] = '\0';
    return result;
}