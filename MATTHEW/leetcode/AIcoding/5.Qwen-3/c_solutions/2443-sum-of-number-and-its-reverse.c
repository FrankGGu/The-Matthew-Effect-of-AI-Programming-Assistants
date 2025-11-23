#include <stdio.h>
#include <stdlib.h>

int sumOfNumberAndReverse(int num) {
    int rev = 0, n = num;
    while (n > 0) {
        rev = rev * 10 + n % 10;
        n /= 10;
    }
    return num + rev;
}