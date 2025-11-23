#include <stdlib.h> // For qsort, bsearch, NULL

int compareInts(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int numComponents(struct ListNode* head, int* nums, int numsSize) {
    if (head == NULL) {
        return 0;
    }

    qsort(nums, numsSize, sizeof(int), compareInts);

    int componentsCount = 0;
    int inComponent = 0; // 0 for false, 1 for true

    struct ListNode* current = head;
    while (current != NULL) {
        int target = current->val;
        void* found = bsearch(&target, nums, numsSize, sizeof(int), compareInts);

        if (found != NULL) {
            if (inComponent == 0) {
                componentsCount++;
                inComponent = 1;
            }
        } else {
            inComponent = 0;
        }
        current = current->next;
    }

    return componentsCount;
}