#include <stdio.h>
#include <stdlib.h>

int distributeCookies(int* cookies, int cookiesSize, int k) {
    int* count = (int*)calloc(k, sizeof(int));
    int result = 0;

    for (int i = 0; i < cookiesSize; i++) {
        int j = 0;
        while (j < k && count[j] == 0) {
            j++;
        }
        if (j < k) {
            count[j] += cookies[i];
        } else {
            break;
        }
        result++;
    }

    free(count);
    return result;
}