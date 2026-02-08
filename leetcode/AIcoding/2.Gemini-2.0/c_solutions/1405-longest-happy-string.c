#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * longestDiverseString(int a, int b, int c){
    char *result = (char *)malloc(sizeof(char) * (a + b + c + 1));
    int len = 0;

    while (a > 0 || b > 0 || c > 0) {
        int maxA = 0, maxB = 0, maxC = 0;
        if ((len < 2 || result[len - 1] != 'a' || result[len - 2] != 'a') && a > 0) maxA = a;
        if ((len < 2 || result[len - 1] != 'b' || result[len - 2] != 'b') && b > 0) maxB = b;
        if ((len < 2 || result[len - 1] != 'c' || result[len - 2] != 'c') && c > 0) maxC = c;

        if (maxA >= maxB && maxA >= maxC) {
            result[len++] = 'a';
            a--;
        } else if (maxB >= maxA && maxB >= maxC) {
            result[len++] = 'b';
            b--;
        } else {
            result[len++] = 'c';
            c--;
        }
    }

    result[len] = '\0';
    return result;
}