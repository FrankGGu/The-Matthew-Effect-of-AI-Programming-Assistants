#include <stdio.h>
#include <stdlib.h>

int maxBalls(int* arr, int arrSize) {
    int max = 0;
    int* count = (int*)calloc(10000, sizeof(int));

    for (int i = 0; i < arrSize; i++) {
        int num = arr[i];
        int sum = 0;
        while (num > 0) {
            sum += num % 10;
            num /= 10;
        }
        count[sum]++;
        if (count[sum] > max) {
            max = count[sum];
        }
    }

    free(count);
    return max;
}