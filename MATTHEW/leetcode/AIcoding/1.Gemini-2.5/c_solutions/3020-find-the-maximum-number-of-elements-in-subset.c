#include <stdlib.h>
#include <stdbool.h>

int compare(const void *a, const void *b) {
    long long val_a = *(long long*)a;
    long long val_b = *(long long*)b;
    if (val_a < val_b) return -1;
    if (val_a > val_b) return 1;
    return 0;
}

typedef struct {
    long long val;
    int count;
    bool visited;
} FreqEntry;

FreqEntry* findEntry(FreqEntry* freqMap, int mapSize, long long target) {
    int low = 0;
    int high = mapSize - 1;
    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (freqMap[mid].val == target) {
            return &freqMap[mid];
        } else if (freqMap[mid].val < target) {
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return NULL;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int maximumLength(int* nums, int numsSize) {
    long long* long_nums = (long long*)malloc(numsSize * sizeof(long long));
    for (int i = 0; i < numsSize; i++) {
        long_nums[i] = nums[i];
    }
    qsort(long_nums, numsSize, sizeof(long long), compare);

    FreqEntry* freqMap = (FreqEntry*)malloc(numsSize * sizeof(FreqEntry));
    int mapSize = 0;
    if (numsSize > 0) {
        freqMap[mapSize].val = long_nums[0];
        freqMap[mapSize].count = 1;
        freqMap[mapSize].visited = false;
        mapSize++;
        for (int i = 1; i < numsSize; i++) {
            if (long_nums[i] == long_nums[i-1]) {
                freqMap[mapSize-1].count++;
            } else {
                freqMap[mapSize].val = long_nums[i];
                freqMap[mapSize].count = 1;
                freqMap[mapSize].visited = false;
                mapSize++;
            }
        }
    }

    int max_k = 0;

    FreqEntry* oneEntry = findEntry(freqMap, mapSize, 1LL);
    if (oneEntry != NULL) {
        max_k = oneEntry->count;
        oneEntry->visited = true;
    } else {
        max_k = 1;
    }

    for (int i = 0; i < mapSize; i++) {
        if (freqMap[i].val == 1LL) continue;

        if (!freqMap[i].visited) {
            long long current_val = freqMap[i].val;
            int current_k = 0;

            while (true) {
                FreqEntry* entry = findEntry(freqMap, mapSize, current_val);
                if (entry == NULL || entry->count == 0) {
                    break;
                }

                current_k++;
                entry->visited = true;

                if (current_val > 3037000000LL) { // Approx sqrt(LLONG_MAX) to prevent overflow
                    break;
                }
                current_val *= current_val;
            }
            max_k = max(max_k, current_k);
        }
    }

    free(freqMap);
    free(long_nums);
    return max_k;
}