#include <stdlib.h> // For qsort, malloc, free

int compareEnvelopes(const void* a, const void* b) {
    const int* env1 = *(const int**)a;
    const int* env2 = *(const int**)b;

    if (env1[0] != env2[0]) {
        return env1[0] - env2[0]; // Sort by width in ascending order
    } else {
        return env2[1] - env1[1]; // If widths are equal, sort by height in descending order
    }
}

int lower_bound(int* arr, int size, int target) {
    int low = 0;
    int high = size - 1;
    int ans = size; // If target is greater than all elements, it should be placed at the end

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (arr[mid] >= target) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans;
}

int maxEnvelopes(int** envelopes, int envelopesSize, int* envelopesColSize) {
    if (envelopesSize == 0) {
        return 0;
    }

    qsort(envelopes, envelopesSize, sizeof(int*), compareEnvelopes);

    int* tails = (int*)malloc(sizeof(int) * envelopesSize);
    if (tails == NULL) {
        return 0; 
    }
    int len = 0; 

    for (int i = 0; i < envelopesSize; i++) {
        int height = envelopes[i][1];

        int j = lower_bound(tails, len, height);

        if (j == len) {
            tails[len] = height;
            len++;
        } else {
            tails[j] = height;
        }
    }

    free(tails);
    return len;
}