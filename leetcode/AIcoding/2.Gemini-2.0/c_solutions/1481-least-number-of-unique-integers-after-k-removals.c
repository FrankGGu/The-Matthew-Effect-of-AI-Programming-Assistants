#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findLeastNumOfUniqueInts(int* arr, int arrSize, int k) {
    int* freq = (int*)malloc(sizeof(int) * 100001);
    for (int i = 0; i <= 100000; i++) {
        freq[i] = 0;
    }

    for (int i = 0; i < arrSize; i++) {
        freq[arr[i]]++;
    }

    int count = 0;
    for (int i = 0; i <= 100000; i++) {
        if (freq[i] > 0) {
            count++;
        }
    }

    int* freq_counts = (int*)malloc(sizeof(int) * (arrSize + 1));
    for (int i = 0; i <= arrSize; i++) {
        freq_counts[i] = 0;
    }

    for (int i = 0; i <= 100000; i++) {
        if (freq[i] > 0) {
            freq_counts[freq[i]]++;
        }
    }

    for (int i = 1; i <= arrSize; i++) {
        if (freq_counts[i] > 0) {
            int remove = k / i;
            if (remove >= freq_counts[i]) {
                k -= i * freq_counts[i];
                count -= freq_counts[i];
            } else {
                count -= remove;
                k = 0;
                break;
            }
        }
    }

    free(freq);
    free(freq_counts);

    return count;
}