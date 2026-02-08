#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int divisorSubstrings(int num, int k) {
    char str[12];
    sprintf(str, "%d", num);
    int n = strlen(str);
    int count = 0;
    for (int i = 0; i <= n - k; i++) {
        char sub[12];
        strncpy(sub, str + i, k);
        sub[k] = '\0';
        int divisor = atoi(sub);
        if (divisor != 0 && num % divisor == 0) {
            count++;
        }
    }
    return count;
}