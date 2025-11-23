#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *abbreviateProduct(int left, int right) {
    long double product = 1.0;
    long long trailing_zeros = 0;
    long long significant_digits = 1;

    for (int i = left; i <= right; i++) {
        int num = i;
        while (num % 2 == 0) {
            num /= 2;
            trailing_zeros++;
        }
        while (num % 5 == 0) {
            num /= 5;
            trailing_zeros++;
        }
        product *= num;
        while (product > 1e10) {
            product /= 10;
        }
        significant_digits = (significant_digits * num) % 100000;
    }

    char *result = (char *)malloc(100 * sizeof(char));
    if (product > 1e5) {
        sprintf(result, "%lld...%05llde%lld", (long long)(product / pow(10, floor(log10(product)) - 4)), significant_digits, trailing_zeros);
    } else {
        sprintf(result, "%llde%lld", significant_digits, trailing_zeros);
    }

    return result;
}