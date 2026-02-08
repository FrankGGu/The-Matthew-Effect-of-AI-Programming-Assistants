#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long countOfIntegers(int a, int b, int c, int d) {
    long long result = 0;
    for (int i = a; i <= b; i++) {
        for (int j = c; j <= d; j++) {
            result++;
        }
    }
    return result;
}