#include <stdbool.h>
#include <string.h>

bool canBeEqual(int* target, int targetSize, int* arr, int arrSize) {
    int counts[1001];
    memset(counts, 0, sizeof(counts));

    for (int i = 0; i < targetSize; i++) {
        counts[target[i]]++;
    }

    for (int i = 0; i < arrSize; i++) {
        counts[arr[i]]--;
    }

    for (int i = 0; i <= 1000; i++) {
        if (counts[i] != 0) {
            return false;
        }
    }

    return true;
}