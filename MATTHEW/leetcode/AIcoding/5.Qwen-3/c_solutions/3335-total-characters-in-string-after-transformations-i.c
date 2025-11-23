#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int scale(int n) {
    if (n == 0) return 0;
    int res = 0;
    while (n > 0) {
        res += n % 10;
        n /= 10;
    }
    return res;
}

int numberOfCharacters(char* s) {
    int len = strlen(s);
    int total = 0;
    for (int i = 0; i < len; i++) {
        int val = s[i] - 'a' + 1;
        total += scale(val);
    }
    return total;
}