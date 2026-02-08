#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

bool isPrime(int num) {
    if (num <= 1) return false;
    if (num <= 3) return true;
    if (num % 2 == 0 || num % 3 == 0) return false;
    for (int i = 5; i * i <= num; i += 6) {
        if (num % i == 0 || num % (i + 2) == 0) return false;
    }
    return true;
}

int largestPrimeSubstringSum(char *n) {
    int maxSum = 0;
    int len = strlen(n);

    for (int i = 0; i < len; i++) {
        for (int j = i + 1; j <= len; j++) {
            char substring[11];
            strncpy(substring, n + i, j - i);
            substring[j - i] = '\0';
            int num = atoi(substring);
            if (isPrime(num)) {
                maxSum += num;
            }
        }
    }

    return maxSum;
}

int main() {
    char n[] = "123456789";
    printf("%d\n", largestPrimeSubstringSum(n));
    return 0;
}