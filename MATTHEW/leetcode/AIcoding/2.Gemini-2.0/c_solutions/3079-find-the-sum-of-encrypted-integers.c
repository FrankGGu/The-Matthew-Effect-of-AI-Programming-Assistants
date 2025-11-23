#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long decrypt(char *s) {
    long long num = 0;
    int sign = 1;
    int i = 0;
    if (s[0] == '-') {
        sign = -1;
        i = 1;
    } else if (s[0] == '+') {
        i = 1;
    }

    while (s[i] != '\0') {
        if (s[i] >= '0' && s[i] <= '9') {
            num = num * 10 + (s[i] - '0');
            if (num > (long long)1e10) return 0;
        } else {
            return 0;
        }
        i++;
    }
    return sign * num;
}

long long sumOfEncryptedIntegers(char **strs, int strsSize) {
    long long sum = 0;
    for (int i = 0; i < strsSize; i++) {
        sum += decrypt(strs[i]);
    }
    return sum;
}