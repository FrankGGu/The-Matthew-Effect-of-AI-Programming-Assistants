#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int digitSquareSum(int n) {
    int sum = 0, digit;
    while (n) {
        digit = n % 10;
        sum += digit * digit;
        n /= 10;
    }
    return sum;
}

bool isHappy(int n) {
    int slow = n, fast = n;
    do {
        slow = digitSquareSum(slow);
        fast = digitSquareSum(digitSquareSum(fast));
    } while (slow != fast);
    return slow == 1;
}