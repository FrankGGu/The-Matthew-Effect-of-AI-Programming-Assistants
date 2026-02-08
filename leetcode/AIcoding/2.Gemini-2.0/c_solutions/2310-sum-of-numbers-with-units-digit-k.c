#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumOfNumbers(int num, int k) {
    if (num == 0) {
        return 0;
    }
    for (int i = 1; i <= 10; i++) {
        if (i * k <= num && (i * k) % 10 == num % 10) {
            return i * k;
        }
    }
    return -1;
}