#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool digitGame(char *n, int k) {
    int len = strlen(n);
    if (len % 2 == 0) {
        return k <= 1;
    } else {
        int odd_count = 0;
        for (int i = 0; i < len; i++) {
            if ((n[i] - '0') % 2 != 0) {
                odd_count++;
            }
        }
        return odd_count > (len + 1) / 2 - (len % 2 == 0 ? 0 : 1);
    }
}