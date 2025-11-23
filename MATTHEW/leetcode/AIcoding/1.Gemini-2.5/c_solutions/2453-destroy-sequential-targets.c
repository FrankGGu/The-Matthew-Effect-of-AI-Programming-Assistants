#include <stdlib.h> // Required for qsort, malloc, free
#include <limits.h> // Required for INT_MAX

typedef struct {
    int remainder;
    int target_val;
} TargetInfo;

int compareTargetInfo(const void *a, const void *b) {
    TargetInfo *infoA = (TargetInfo *)a;
    TargetInfo *infoB = (TargetInfo *)b;

    if (infoA->remainder != infoB->remainder) {
        return infoA->remainder - infoB->remainder;
    }
    // If remainders are equal, sort by target_val to ensure
    // the smallest target_val for a given remainder comes first.
    return infoA->target_val - infoB->target_val;
}

int destroySequentialTargets(int* targets, int targetsSize, int space) {
    TargetInfo *infos = (TargetInfo *)malloc(targetsSize * sizeof(TargetInfo));

    for (int i = 0; i < targetsSize; i++) {
        infos[i].remainder = targets[i] % space;
        infos[i].target_val = targets[i];
    }

    qsort(infos, targetsSize, sizeof(TargetInfo), compareTargetInfo);

    int max_destroyed_count = 0;
    int min_start = INT_MAX;

    int current_count = 0;
    int current_start_candidate = infos[0].target_val; 

    for (int i = 0; i < targetsSize; i++) {
        current_count++;
        if (i == targetsSize - 1 || infos[i].remainder != infos[i+1].remainder) {
            if (current_count > max_destroyed_count) {
                max_destroyed_count = current_count;
                min_start = current_start_candidate;
            } else if (current_count == max_destroyed_count) {
                if (current_start_candidate < min_start) {
                    min_start = current_start_candidate;
                }
            }
            current_count = 0;
            if (i < targetsSize - 1) {
                current_start_candidate = infos[i+1].target_val;
            }
        }
    }

    free(infos);
    return min_start;
}