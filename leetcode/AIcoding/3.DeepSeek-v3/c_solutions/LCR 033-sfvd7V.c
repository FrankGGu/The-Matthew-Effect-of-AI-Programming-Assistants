/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the return arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */

typedef struct {
    char* key;
    int index;
    UT_hash_handle hh;
} HashNode;

int cmp(const void* a, const void* b) {
    return *(char*)a - *(char*)b;
}

char*** groupAnagrams(char** strs, int strsSize, int* returnSize, int** returnColumnSizes) {
    if (strsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    HashNode* map = NULL;
    char*** result = (char***)malloc(strsSize * sizeof(char**));
    *returnColumnSizes = (int*)malloc(strsSize * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < strsSize; i++) {
        int len = strlen(strs[i]);
        char* sorted = (char*)malloc((len + 1) * sizeof(char));
        strcpy(sorted, strs[i]);
        qsort(sorted, len, sizeof(char), cmp);

        HashNode* entry = NULL;
        HASH_FIND_STR(map, sorted, entry);

        if (entry == NULL) {
            entry = (HashNode*)malloc(sizeof(HashNode));
            entry->key = sorted;
            entry->index = *returnSize;
            HASH_ADD_KEYPTR(hh, map, entry->key, strlen(entry->key), entry);

            result[entry->index] = (char**)malloc(strsSize * sizeof(char*));
            result[entry->index][0] = strs[i];
            (*returnColumnSizes)[entry->index] = 1;
            (*returnSize)++;
        } else {
            int idx = entry->index;
            result[idx][(*returnColumnSizes)[idx]] = strs[i];
            (*returnColumnSizes)[idx]++;
            free(sorted);
        }
    }

    HashNode *current, *tmp;
    HASH_ITER(hh, map, current, tmp) {
        HASH_DEL(map, current);
        free(current->key);
        free(current);
    }

    return result;
}