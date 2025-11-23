#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char findKthBit(int n, int k) {
    char* s = (char*)malloc(sizeof(char) * (1 << n));
    s[0] = '1';
    for (int i = 2; i <= n; i++) {
        int len = 1 << (i - 1);
        memcpy(s + len, s, len);
        for (int j = 0; j < len; j++) {
            s[len + j] = (s[j] == '1') ? '0' : '1';
        }
        s[len + len] = '1';
    }
    char result = s[k - 1];
    free(s);
    return result;
}