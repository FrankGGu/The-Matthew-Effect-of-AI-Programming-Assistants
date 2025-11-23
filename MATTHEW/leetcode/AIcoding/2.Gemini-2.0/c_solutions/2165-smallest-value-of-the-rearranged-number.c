#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long smallestNumber(long long num) {
    if (num == 0) {
        return 0;
    }

    bool isNegative = false;
    if (num < 0) {
        isNegative = true;
        num = -num;
    }

    int digits[10] = {0};
    while (num > 0) {
        digits[num % 10]++;
        num /= 10;
    }

    long long result = 0;
    if (!isNegative) {
        int firstNonZero = -1;
        for (int i = 1; i < 10; i++) {
            if (digits[i] > 0) {
                firstNonZero = i;
                digits[i]--;
                break;
            }
        }
        result = firstNonZero;
        for (int i = 0; i < 10; i++) {
            while (digits[i] > 0) {
                result = result * 10 + i;
                digits[i]--;
            }
        }
    } else {
        for (int i = 9; i >= 0; i--) {
            while (digits[i] > 0) {
                result = result * 10 + i;
                digits[i]--;
            }
        }
        result = -result;
    }

    return result;
}