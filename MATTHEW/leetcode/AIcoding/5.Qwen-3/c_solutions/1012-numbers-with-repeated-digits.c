#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numDupDigits(int n) {
    int count = 0;
    for (int i = 1; i <= n; i++) {
        int temp = i;
        int digits[10] = {0};
        int flag = 0;
        while (temp > 0) {
            int d = temp % 10;
            if (digits[d] == 1) {
                flag = 1;
                break;
            }
            digits[d] = 1;
            temp /= 10;
        }
        if (flag) count++;
    }
    return count;
}