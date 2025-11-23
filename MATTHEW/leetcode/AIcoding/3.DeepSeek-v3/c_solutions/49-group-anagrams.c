/**
 * Return an array of arrays of size *returnSize.
 * The sizes of the arrays are returned as *returnColumnSizes array.
 * Note: Both returned array and *columnSizes array must be malloced, assume caller calls free().
 */

typedef struct {
    char* key;
    int index;
    UT_hash_handle hh;
} HashNode;

int compare(const void* a, const void* b) {
    return *(char*)a - *(char*)b;
}

char*** groupAnagrams(char** strs, int strsSize, int* returnSize, int** returnColumnSizes) {
    if (strsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    HashNode* map = NULL;
    char*** result = NULL;
    *returnColumnSizes = NULL;
    *returnSize = 0;

    for (int i = 0; i < strsSize; i++) {
        int len = strlen(strs[i]);
        char* sorted = malloc(len + 1);
        strcpy(sorted, strs[i]);
        qsort(sorted, len, sizeof(char), compare);

        HashNode* entry = NULL;
        HASH_FIND_STR(map, sorted, entry);

        if (entry == NULL) {
            entry = malloc(sizeof(HashNode));
            entry->key = sorted;
            entry->index = *returnSize;
            HASH_ADD_KEYPTR(hh, map, entry->key, strlen(entry->key), entry);

            (*returnSize)++;
            result = realloc(result, (*returnSize) * sizeof(char**));
            returnColumnSizes[0] = realloc(returnColumnSizes[0], (*returnSize) * sizeof(int));

            result[entry->index] = malloc(sizeof(char*));
            result[entry->index][0] = strs[i];
            returnColumnSizes[0][entry->index] = 1;
        } else {
            int idx = entry->index;
            int colSize = returnColumnSizes[0][idx];
            result[idx] = realloc(result[idx], (colSize + 1) * sizeof(char*));
            result[idx][colSize] = strs[i];
            returnColumnSizes[0][idx] = colSize + 1;
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