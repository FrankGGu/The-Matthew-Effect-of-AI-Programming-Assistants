#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int digitSum(int n) {
    int sum = 0;
    while (n > 0) {
        sum += n % 10;
        n /= 10;
    }
    return sum;
}

int countLargestGroup(int n) {
    int counts[37] = {0};
    for (int i = 1; i <= n; i++) {
        counts[digitSum(i)]++;
    }

    int maxCount = 0;
    for (int i = 1; i < 37; i++) {
        if (counts[i] > maxCount) {
            maxCount = counts[i];
        }
    }

    int result = 0;
    for (int i = 1; i < 37; i++) {
        if (counts[i] == maxCount) {
            result++;
        }
    }

    return result;
}