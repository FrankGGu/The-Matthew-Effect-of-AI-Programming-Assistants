#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int threeSumMulti(int* arr, int arrSize, int target) {
    qsort(arr, arrSize, sizeof(int), compare);
    int count = 0;
    for (int i = 0; i < arrSize; i++) {
        int left = i + 1;
        int right = arrSize - 1;
        while (left < right) {
            int sum = arr[i] + arr[left] + arr[right];
            if (sum == target) {
                count++;
                int leftVal = arr[left];
                int rightVal = arr[right];
                while (left < right && arr[left] == leftVal) left++;
                while (left < right && arr[right] == rightVal) right--;
            } else if (sum < target) {
                left++;
            } else {
                right--;
            }
        }
    }
    return count;
}