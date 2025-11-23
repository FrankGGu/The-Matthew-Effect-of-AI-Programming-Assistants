typedef struct {
    int key;
    int val;
    UT_hash_handle hh;
} HashItem;

int longestSubsequence(int* arr, int arrSize, int difference) {
    HashItem *dp = NULL;
    int maxLen = 0;

    for (int i = 0; i < arrSize; i++) {
        int prev = arr[i] - difference;
        HashItem *pEntry = NULL;
        HASH_FIND_INT(dp, &prev, pEntry);

        int currentLen = 1;
        if (pEntry != NULL) {
            currentLen = pEntry->val + 1;
        }

        HashItem *entry = NULL;
        HASH_FIND_INT(dp, &arr[i], entry);
        if (entry != NULL) {
            if (currentLen > entry->val) {
                entry->val = currentLen;
            }
        } else {
            entry = (HashItem*)malloc(sizeof(HashItem));
            entry->key = arr[i];
            entry->val = currentLen;
            HASH_ADD_INT(dp, key, entry);
        }

        if (currentLen > maxLen) {
            maxLen = currentLen;
        }
    }

    HashItem *curr, *tmp;
    HASH_ITER(hh, dp, curr, tmp) {
        HASH_DEL(dp, curr);
        free(curr);
    }

    return maxLen;
}