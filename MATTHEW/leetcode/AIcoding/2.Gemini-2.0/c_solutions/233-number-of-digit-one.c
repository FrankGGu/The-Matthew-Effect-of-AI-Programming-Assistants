#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countDigitOne(int n) {
    int count = 0;
    long long i = 1;
    while (n / i != 0) {
        long long currentDigit = (n / i) % 10;
        long long higherDigits = n / (i * 10);
        long long lowerDigits = n % i;

        if (currentDigit == 0) {
            count += higherDigits * i;
        } else if (currentDigit == 1) {
            count += higherDigits * i + lowerDigits + 1;
        } else {
            count += (higherDigits + 1) * i;
        }
        i *= 10;
    }
    return count;
}