#include <stdio.h>
#include <stdlib.h>

int* pancakeSorting(int* arr, int arrSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * arrSize);
    int index = 0;
    int i = arrSize;

    while (i > 1) {
        int maxIndex = 0;
        for (int j = 1; j < i; j++) {
            if (arr[j] > arr[maxIndex]) {
                maxIndex = j;
            }
        }

        if (maxIndex == i - 1) {
            i--;
            continue;
        }

        if (maxIndex != 0) {
            result[index++] = maxIndex + 1;
            int left = 0;
            int right = maxIndex;
            while (left < right) {
                int temp = arr[left];
                arr[left] = arr[right];
                arr[right] = temp;
                left++;
                right--;
            }
        }

        result[index++] = i;
        int left = 0;
        int right = i - 1;
        while (left < right) {
            int temp = arr[left];
            arr[left] = arr[right];
            arr[right] = temp;
            left++;
            right--;
        }

        i--;
    }

    *returnSize = index;
    return result;
}