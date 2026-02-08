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

int maxBalls(int lowLimit, int highLimit) {
    int counts[46] = {0};
    int maxCount = 0;
    for (int i = lowLimit; i <= highLimit; i++) {
        int sum = digitSum(i);
        counts[sum]++;
        if (counts[sum] > maxCount) {
            maxCount = counts[sum];
        }
    }
    return maxCount;
}