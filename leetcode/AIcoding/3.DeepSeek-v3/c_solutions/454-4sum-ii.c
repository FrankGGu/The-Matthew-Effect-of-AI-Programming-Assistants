typedef struct {
    int key;
    int val;
    UT_hash_handle hh;
} hash_map;

int fourSumCount(int* nums1, int nums1Size, int* nums2, int nums2Size, int* nums3, int nums3Size, int* nums4, int nums4Size) {
    hash_map *map = NULL;
    for (int i = 0; i < nums1Size; i++) {
        for (int j = 0; j < nums2Size; j++) {
            int sum = nums1[i] + nums2[j];
            hash_map *entry;
            HASH_FIND_INT(map, &sum, entry);
            if (entry) {
                entry->val++;
            } else {
                entry = malloc(sizeof(hash_map));
                entry->key = sum;
                entry->val = 1;
                HASH_ADD_INT(map, key, entry);
            }
        }
    }

    int count = 0;
    for (int i = 0; i < nums3Size; i++) {
        for (int j = 0; j < nums4Size; j++) {
            int target = - (nums3[i] + nums4[j]);
            hash_map *entry;
            HASH_FIND_INT(map, &target, entry);
            if (entry) {
                count += entry->val;
            }
        }
    }

    hash_map *curr, *tmp;
    HASH_ITER(hh, map, curr, tmp) {
        HASH_DEL(map, curr);
        free(curr);
    }

    return count;
}