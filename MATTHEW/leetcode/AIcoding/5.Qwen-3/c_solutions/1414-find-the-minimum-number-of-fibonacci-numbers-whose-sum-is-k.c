#include <stdio.h>
#include <stdlib.h>

int findMinFibonacciNumbers(char* k) {
    int k_int = atoi(k);
    int a = 1, b = 1;
    int count = 0;
    while (a <= k_int) {
        int temp = a;
        a = b;
        b = temp + b;
        if (a > k_int) {
            a = temp;
            b = a + temp;
        }
        if (a <= k_int) {
            k_int -= a;
            count++;
        }
    }
    return count;
}