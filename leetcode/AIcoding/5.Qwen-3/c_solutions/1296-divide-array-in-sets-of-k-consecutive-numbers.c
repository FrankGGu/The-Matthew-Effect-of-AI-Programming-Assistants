#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int key;
    int value;
} Pair;

int compare(const void *a, const void *b) {
    return ((Pair *)a)->key - ((Pair *)b)->key;
}

bool isPossibleDivide(int* nums, int numsSize, int k) {
    if (numsSize % k != 0) return false;

    int count = 0;
    Pair *freq = (Pair *)malloc(numsSize * sizeof(Pair));
    for (int i = 0; i < numsSize; i++) {
        freq[i].key = nums[i];
        freq[i].value = 1;
    }

    qsort(freq, numsSize, sizeof(Pair), compare);

    for (int i = 0; i < numsSize; i++) {
        if (freq[i].value == 0) continue;
        int current = freq[i].key;
        for (int j = 0; j < k; j++) {
            int next = current + j;
            bool found = false;
            for (int m = i + 1; m < numsSize; m++) {
                if (freq[m].key == next && freq[m].value > 0) {
                    freq[m].value--;
                    found = true;
                    break;
                }
            }
            if (!found) {
                free(freq);
                return false;
            }
        }
    }

    free(freq);
    return true;
}