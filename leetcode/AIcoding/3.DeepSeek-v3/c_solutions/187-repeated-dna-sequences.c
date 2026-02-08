typedef struct {
    char* key;
    int count;
    UT_hash_handle hh;
} HashEntry;

char** findRepeatedDnaSequences(char* s, int* returnSize) {
    if (strlen(s) < 10) {
        *returnSize = 0;
        return NULL;
    }

    HashEntry* map = NULL;
    HashEntry* tmp = NULL;
    int n = strlen(s);
    char** result = NULL;
    *returnSize = 0;

    for (int i = 0; i <= n - 10; i++) {
        char* substr = malloc(11 * sizeof(char));
        strncpy(substr, s + i, 10);
        substr[10] = '\0';

        HASH_FIND_STR(map, substr, tmp);
        if (tmp) {
            tmp->count++;
        } else {
            tmp = malloc(sizeof(HashEntry));
            tmp->key = substr;
            tmp->count = 1;
            HASH_ADD_KEYPTR(hh, map, tmp->key, 10, tmp);
        }
    }

    HashEntry* current;
    HashEntry* temp;
    HASH_ITER(hh, map, current, temp) {
        if (current->count > 1) {
            (*returnSize)++;
            result = realloc(result, (*returnSize) * sizeof(char*));
            result[(*returnSize) - 1] = current->key;
        } else {
            free(current->key);
        }
        HASH_DEL(map, current);
        free(current);
    }

    return result;
}