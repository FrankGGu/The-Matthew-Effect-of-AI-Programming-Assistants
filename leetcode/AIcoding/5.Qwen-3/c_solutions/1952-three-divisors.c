#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int isThree(int n) {
    int count = 0;
    for (int i = 1; i <= sqrt(n); i++) {
        if (n % i == 0) {
            count++;
            if (i != n / i) {
                count++;
            }
        }
    }
    return count == 3;
}