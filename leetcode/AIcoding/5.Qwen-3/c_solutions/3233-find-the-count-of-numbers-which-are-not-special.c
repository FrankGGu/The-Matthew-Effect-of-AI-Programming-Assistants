#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int isSpecial(int num) {
    int n = num;
    int count = 0;
    while (n > 0) {
        n /= 10;
        count++;
    }
    int half = count / 2;
    int first = num;
    for (int i = 0; i < half; i++) {
        first /= 10;
    }
    int second = num % (int)pow(10, half);
    return first == second;
}

int numberOfNonSpecialCount(int low, int high) {
    int count = 0;
    for (int i = low; i <= high; i++) {
        if (!isSpecial(i)) {
            count++;
        }
    }
    return count;
}