#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findLatestStep(int* arr, int arrSize, int m) {
    if (m == arrSize) return arrSize;
    int* length = (int*)malloc((arrSize + 2) * sizeof(int));
    int* count = (int*)malloc((arrSize + 1) * sizeof(int));
    for (int i = 0; i <= arrSize + 1; i++) length[i] = 0;
    for (int i = 0; i <= arrSize; i++) count[i] = 0;

    int ans = -1;
    for (int i = 0; i < arrSize; i++) {
        int a = arr[i];
        int left = length[a - 1];
        int right = length[a + 1];
        length[a - left] = left + right + 1;
        length[a + right] = left + right + 1;
        length[a] = left + right + 1;
        count[left]--;
        count[right]--;
        count[left + right + 1]++;
        if (count[m] > 0) ans = i + 1;
    }
    free(length);
    free(count);
    return ans;
}