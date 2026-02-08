#include <stdlib.h>

int compare(const void *a, const void *b) {
    int val_a = *(const int*)a;
    int val_b = *(const int*)b;
    if (val_a < val_b) return -1;
    if (val_a > val_b) return 1;
    return 0;
}

int maxGroups(int* usageLimits, int usageLimitsSize) {
    qsort(usageLimits, usageLimitsSize, sizeof(int), compare);

    long long current_groups = 0;
    long long total_items_count = 0;

    for (int i = 0; i < usageLimitsSize; i++) {
        total_items_count += usageLimits[i];
        if (total_items_count >= (current_groups + 1) * (current_groups + 2) / 2) {
            current_groups++;
        }
    }

    return (int)current_groups;
}