#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int divisorSubstrings(int num, int k) {
    char s[12];
    sprintf(s, "%d", num);

    int n = strlen(s);
    int count = 0;

    for (int i = 0; i <= n - k; i++) {
        char sub[12];
        strncpy(sub, s + i, k);
        sub[k] = '\0';

        int sub_num = atoi(sub);

        if (sub_num != 0 && num % sub_num == 0) {
            count++;
        }
    }

    return count;
}