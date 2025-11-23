#include <stdio.h>
#include <stdlib.h>

int sumOfPrimeFactors(int n) {
    int sum = 0;
    for (int i = 2; i * i <= n; i++) {
        while (n % i == 0) {
            sum += i;
            n /= i;
        }
    }
    if (n > 1) {
        sum += n;
    }
    return sum;
}

int smallestValue(int n){
    int current = n;
    while (1) {
        int next = sumOfPrimeFactors(current);
        if (next == current) {
            break;
        }
        current = next;
    }
    return current;
}