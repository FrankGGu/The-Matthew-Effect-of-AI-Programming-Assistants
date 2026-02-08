#include <stdlib.h>
#include "uthash.h"

struct FreqEntry {
    int position;
    int count;
    UT_hash_handle hh;
};

int leastBricks(int** wall, int wallSize, int* wallColSize) {
    struct FreqEntry *freq_map = NULL;
    int max_freq = 0;

    for (int i = 0; i < wallSize; i++) {
        int current_sum = 0;
        for (int j = 0; j < wallColSize[i] - 1; j++) {
            current_sum += wall[i][j];
            struct FreqEntry *entry;

            HASH_FIND_INT(freq_map, &current_sum, entry);

            if (entry == NULL) {
                entry = (struct FreqEntry*) malloc(sizeof(struct FreqEntry));
                entry->position = current_sum;
                entry->count = 1;
                HASH_ADD_INT(freq_map, position, entry);
            } else {
                entry->count++;
            }

            if (entry->count > max_freq) {
                max_freq = entry->count;
            }
        }
    }

    struct FreqEntry *current_entry, *tmp;
    HASH_ITER(hh, freq_map, current_entry, tmp) {
        HASH_DEL(freq_map, current_entry);
        free(current_entry);
    }

    return wallSize - max_freq;
}