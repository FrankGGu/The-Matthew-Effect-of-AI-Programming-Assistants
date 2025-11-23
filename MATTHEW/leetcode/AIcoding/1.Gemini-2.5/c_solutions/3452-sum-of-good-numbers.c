#include <stdbool.h>

int sumDigits(int num) {
    int sum = 0;
    while (num > 0) {
        sum += num % 10;
        num /= 10;
    }
    return sum;
}

bool isGood(int num) {
    return sumDigits(num) % 2 == 0;
}

long long sumOfGoodNumbers(int n) {
    long long totalSum = 0;
    for (int i = 1; i <= n; i++) {
        if (isGood(i)) {
            totalSum += i;
        }
    }
    return totalSum;
}