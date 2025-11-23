#include <stdio.h>
#include <stdlib.h>

int maxScore(int a, int b, int c) {
    int sum = a + b + c;
    int min = (a < b) ? (a < c ? a : c) : (b < c ? b : c);
    if (sum % 3 == 0) {
        return sum / 3;
    } else {
        return (sum - min) / 3;
    }
}