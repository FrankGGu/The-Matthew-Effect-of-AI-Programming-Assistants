#include <stdio.h>
#include <stdlib.h>

long long concatenatedBinary(int n) {
    long long result = 0;
    int i;
    for (i = 1; i <= n; i++) {
        int length = 0;
        int num = i;
        while (num > 0) {
            num >>= 1;
            length++;
        }
        result = (result << length) | i;
    }
    return result;
}