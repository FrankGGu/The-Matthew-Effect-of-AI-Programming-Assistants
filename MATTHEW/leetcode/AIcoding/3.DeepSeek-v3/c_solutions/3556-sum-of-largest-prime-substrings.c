#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <math.h>

bool isPrime(int n) {
    if (n <= 1) return false;
    if (n <= 3) return true;
    if (n % 2 == 0 || n % 3 == 0) return false;
    for (int i = 5; i * i <= n; i += 6) {
        if (n % i == 0 || n % (i + 2) == 0) return false;
    }
    return true;
}

int largestPrimeSubstring(char* s) {
    int maxPrime = -1;
    int len = strlen(s);

    for (int i = 0; i < len; i++) {
        for (int j = i; j < len; j++) {
            if (j - i + 1 > 6) continue;

            int num = 0;
            for (int k = i; k <= j; k++) {
                num = num * 10 + (s[k] - '0');
            }

            if (num > 1000000) continue;

            if (isPrime(num) && num > maxPrime) {
                maxPrime = num;
            }
        }
    }

    return maxPrime == -1 ? 0 : maxPrime;
}

int sumOfLargestPrimeSubstrings(char* s) {
    int sum = 0;
    int len = strlen(s);
    int i = 0;

    while (i < len) {
        int maxPrime = -1;

        for (int j = i; j < len; j++) {
            char temp[7];
            int idx = 0;
            for (int k = i; k <= j && idx < 6; k++) {
                temp[idx++] = s[k];
            }
            temp[idx] = '\0';

            int num = atoi(temp);
            if (num > 1000000) continue;

            if (isPrime(num) && num > maxPrime) {
                maxPrime = num;
            }
        }

        if (maxPrime != -1) {
            sum += maxPrime;
            i += snprintf(NULL, 0, "%d", maxPrime);
        } else {
            i++;
        }
    }

    return sum;
}