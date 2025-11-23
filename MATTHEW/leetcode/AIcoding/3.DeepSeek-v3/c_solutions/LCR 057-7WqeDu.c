#include <stdlib.h>

typedef struct {
    long long key;
    int index;
} Item;

int cmp(const void* a, const void* b) {
    Item* ia = (Item*)a;
    Item* ib = (Item*)b;
    if (ia->key < ib->key) return -1;
    if (ia->key > ib->key) return 1;
    return ia->index - ib->index;
}

bool containsNearbyAlmostDuplicate(int* nums, int numsSize, int indexDiff, int valueDiff) {
    if (numsSize <= 1 || indexDiff < 0 || valueDiff < 0) return false;

    Item* items = (Item*)malloc(numsSize * sizeof(Item));
    for (int i = 0; i < numsSize; i++) {
        items[i].key = (long long)nums[i];
        items[i].index = i;
    }

    qsort(items, numsSize, sizeof(Item), cmp);

    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (items[j].key - items[i].key > valueDiff) break;
            if (abs(items[j].index - items[i].index) <= indexDiff) {
                free(items);
                return true;
            }
        }
    }

    free(items);
    return false;
}