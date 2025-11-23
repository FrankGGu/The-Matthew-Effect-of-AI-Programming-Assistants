#include <stdio.h>
#include <stdlib.h>

int clumsy(int n) {
    if (n == 1) return 1;
    if (n == 2) return 2;
    if (n == 3) return 6;
    int result = n;
    int i = 1;
    while (i < n) {
        if (i % 4 == 1) {
            result *= (i + 1);
        } else if (i % 4 == 2) {
            result /= (i + 1);
        } else if (i % 4 == 3) {
            result -= (i + 1);
        } else {
            result += (i + 1);
        }
        i++;
    }
    return result;
}