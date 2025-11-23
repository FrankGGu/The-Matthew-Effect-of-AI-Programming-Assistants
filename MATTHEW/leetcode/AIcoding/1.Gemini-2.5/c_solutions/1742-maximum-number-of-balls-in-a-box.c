#include <stdlib.h>
#include <string.h>

int countBalls(int lowLimit, int highLimit) {
    int* boxCounts = (int*)calloc(highLimit + 1, sizeof(int));
    if (boxCounts == NULL) {
        return 0; // Handle memory allocation failure
    }

    int maxCount = 0;

    for (int i = lowLimit; i <= highLimit; ++i) {
        int num = i;
        int sumDigits = 0;
        while (num > 0) {
            sumDigits += num % 10;
            num /= 10;
        }
        boxCounts[sumDigits]++;
        if (boxCounts[sumDigits] > maxCount) {
            maxCount = boxCounts[sumDigits];
        }
    }

    free(boxCounts);
    return maxCount;
}