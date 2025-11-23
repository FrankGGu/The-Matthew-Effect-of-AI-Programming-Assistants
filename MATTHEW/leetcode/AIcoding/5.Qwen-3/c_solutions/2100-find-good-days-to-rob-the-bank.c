#include <stdio.h>
#include <stdlib.h>

int* goodDaysToRobBank(int* security, int securitySize, int time, int* returnSize) {
    int* result = (int*)malloc(securitySize * sizeof(int));
    int count = 0;

    for (int i = 0; i < securitySize; i++) {
        int left = 0;
        int right = 0;

        for (int j = i - 1; j >= 0 && left <= time; j--) {
            if (security[j] >= security[j + 1]) {
                left++;
            } else {
                break;
            }
        }

        for (int j = i + 1; j < securitySize && right <= time; j++) {
            if (security[j] >= security[j - 1]) {
                right++;
            } else {
                break;
            }
        }

        if (left >= time && right >= time) {
            result[count++] = i;
        }
    }

    *returnSize = count;
    return result;
}