#include <stdlib.h>
#include "uthash.h"

typedef struct {
    int sum;
    int count;
    UT_hash_handle hh;
} SumCountEntry;

int subarraySum(int* nums, int numsSize, int k) {
    SumCountEntry *sum_counts = NULL;
    SumCountEntry *entry;
    int current_sum = 0;
    int total_count = 0;

    entry = (SumCountEntry*) malloc(sizeof(SumCountEntry));
    entry->sum = 0;
    entry->count = 1;
    HASH_ADD_INT(sum_counts, sum, entry);

    for (int i = 0; i < numsSize; i++) {
        current_sum += nums[i];

        int target_sum = current_sum - k;
        HASH_FIND_INT(sum_counts, &target_sum, entry);
        if (entry != NULL) {
            total_count += entry->count;
        }

        HASH_FIND_INT(sum_counts, &current_sum, entry);
        if (entry != NULL) {
            entry->count++;
        } else {
            entry = (SumCountEntry*) malloc(sizeof(SumCountEntry));
            entry->sum = current_sum;
            entry->count = 1;
            HASH_ADD_INT(sum_counts, sum, entry);
        }
    }

    SumCountEntry *current_entry, *tmp_entry;
    HASH_ITER(hh, sum_counts, current_entry, tmp_entry) {
        HASH_DEL(sum_counts, current_entry);
        free(current_entry);
    }

    return total_count;
}