#include <stdio.h>
#include <stdlib.h>

int countDigits(int num) {
    int count = 0;
    int original = num;
    while (num > 0) {
        int digit = num % 10;
        if (original % digit == 0) {
            count++;
        }
        num /= 10;
    }
    return count;
}