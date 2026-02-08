typedef struct {
    int key;
    int count;
    UT_hash_handle hh;
} HashMap;

int maxSubarrayLength(int* nums, int numsSize, int k) {
    HashMap *map = NULL;
    int left = 0;
    int maxLen = 0;

    for (int right = 0; right < numsSize; right++) {
        HashMap *entry = NULL;
        HASH_FIND_INT(map, &nums[right], entry);
        if (entry == NULL) {
            entry = malloc(sizeof(HashMap));
            entry->key = nums[right];
            entry->count = 0;
            HASH_ADD_INT(map, key, entry);
        }
        entry->count++;

        while (entry->count > k) {
            HashMap *leftEntry = NULL;
            HASH_FIND_INT(map, &nums[left], leftEntry);
            if (leftEntry) {
                leftEntry->count--;
                if (leftEntry->count == 0) {
                    HASH_DEL(map, leftEntry);
                    free(leftEntry);
                }
            }
            left++;
        }

        maxLen = (right - left + 1 > maxLen) ? right - left + 1 : maxLen;
    }

    HashMap *current, *tmp;
    HASH_ITER(hh, map, current, tmp) {
        HASH_DEL(map, current);
        free(current);
    }

    return maxLen;
}