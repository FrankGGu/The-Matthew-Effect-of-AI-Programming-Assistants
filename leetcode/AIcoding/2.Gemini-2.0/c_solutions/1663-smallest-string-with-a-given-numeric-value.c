#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char * getSmallestString(int n, int k){
    char *result = (char *)malloc(sizeof(char) * (n + 1));
    memset(result, 0, sizeof(char) * (n + 1));

    for (int i = 0; i < n; i++) {
        result[i] = 'a';
    }

    k -= n;

    for (int i = n - 1; i >= 0; i--) {
        if (k == 0) {
            break;
        }
        if (k >= 25) {
            result[i] = 'z';
            k -= 25;
        } else {
            result[i] = 'a' + k;
            k = 0;
        }
    }

    return result;
}