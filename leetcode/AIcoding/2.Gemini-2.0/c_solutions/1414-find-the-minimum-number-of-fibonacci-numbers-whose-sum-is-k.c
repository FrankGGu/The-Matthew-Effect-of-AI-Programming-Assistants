#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findMinFibonacciNumbers(int k) {
    int fib[45] = {1, 1};
    int count = 2;
    while (fib[count - 1] <= k) {
        fib[count] = fib[count - 1] + fib[count - 2];
        count++;
    }
    count--;
    int res = 0;
    while (k > 0) {
        if (fib[count - 1] <= k) {
            k -= fib[count - 1];
            res++;
        } else {
            count--;
            continue;
        }
        count--;
    }
    return res;
}